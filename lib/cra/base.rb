# -*- encoding : utf-8 -*-
require 'builder'
require 'bundler/cli'

class CRA::Base
  attr_accessor :last_action, :last_request, :last_response

  def tokenize_service(service)
    case service
    when 'GetDataUsingCriteriaParameter'
      'ძებნა სახელით და დაბ. დღით'
    when 'GetDataUsingPrivateNumberAndIdCardParameter'
      'ძებნა პირადობის მოწმობით'
    when 'FetchPersonInfoByPassportNumberUsingCriteriaParameter'
      'ძებნა პასპორტით'
    else
      service
    end
  end

  def gov_talk_request(options)
    self.last_action = tokenize_service(options[:service])
    self.last_request = options[:params]
    # create xml
    xml = xml_generation(options)
    file1 = gen_filename
    file2 = gen_filename
    begin
      # make signature
      File.open(file1, 'w') do |f|
        f.write(xml)
      end
      if File.exists?('bin/cra.exe')
        path_to_exe = 'bin/cra.exe'
      else
        # path_to_exe = "#{Bundler::CLI.new.send(:locate_gem, 'cra.ge')}/bin/cra.exe"
        path_to_exe = File.join(Gem::Specification.find_by_name('cra.ge').gem_dir, '/bin/cra.exe')
      end
      %x[ mono #{path_to_exe} '#{CRA.config.cert_file}' '#{CRA.config.cert_password}' '#{file1}' '#{file2}' ]
      # send request
      xml2 = File.read(file2)
      response = RestClient.post CRA.config.url, xml2, :content_type => :xml
      hash = Hash.from_xml(response.body)
      # manage response
      if hash['GovTalkMessage']['Header']['MessageDetails']['Qualifier'] == 'error'
        ex_root = hash['GovTalkMessage']['GovTalkDetails']['GovTalkErrors']['Error']
        ex_text = "#{ex_root['Type'].upcase}-#{ex_root['Number']}: #{ex_root['Text']}"
        self.last_response = ex_text
        raise CRA::ServiceException, ex_text
      elsif hash['GovTalkMessage']['Body']['ErrorResult']
        ex_root = hash['GovTalkMessage']['Body']['ErrorResult']
        ex_text = "#{ex_root['Message']}"
        self.last_response = ex_text
        raise CRA::ServiceException, ex_text
      end
      hash['GovTalkMessage']['Body']
      self.last_response = hash['GovTalkMessage']['Body']
    ensure
      FileUtils.rm(file1)
      FileUtils.rm(file2)
    end
  end

  private

  def xml_generation(options)
    service_name = options[:service]
    class_name   = options[:class]
    message_name = options[:message]
    params       = options[:params]
    xml = Builder::XmlMarkup.new( :indent => 2 )
    xml.instruct! :xml, :encoding => 'utf-8'
    xml.GovTalkMessage(xmlns: 'http://www.govtalk.gov.uk/CM/envelope') do |xml|
      xml.EnvelopeVersion '2.0'
      xml.Header do |xml|
        xml.MessageDetails do |xml|
          xml.Class class_name
          xml.Qualifier 'request'
          xml.Function 'submit'
        end
        xml.SenderDetails do |xml|
          xml.IDAuthentication do |xml|
            xml.SenderID CRA.config.user
            xml.Authentication do |xml|
              xml.Method 'clear'
              xml.Value CRA.config.password
            end
          end
        end
      end
      xml.Body do |xml|
        xml.Message(xmlns: "urn:g3.ge:cra:call:#{message_name}:v1") do |xml|
          xml.Data do |xml|
            xml.Request do |xml|
              if params.size < 2
                params.each do |k, v|
                  xml.tag!(k, v)
                end
              else
                xml.tag! service_name do |xml|
                  params.each do |k, v|
                    xml.tag!(k, v)
                  end
                end
              end
            end
          end
          xml.Thumbprint CRA.config.cert_trace
        end
      end
    end
  end

  def gen_filename
    FileUtils.mkdir_p('tmp')
    "tmp/#{Digest::MD5.hexdigest "#{Time.now}#{rand(100)}"}.xml"
  end

end
