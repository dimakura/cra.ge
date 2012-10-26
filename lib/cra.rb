# -*- encoding : utf-8 -*-
require 'savon'
require 'cra/version'

require 'cra/config'

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

module CRA
  BASE_URL = 'http://stateinstitution.cra.ge'
  WSDL_URL = 'https://stateinstitutions.cra.ge/Service.asmx?WSDL'

  MALE = 1
  FEMALE = 2

  class Base

    def get_client
      Savon::Client.new WSDL_URL do 
        http.auth.ssl.cert_file = CRA.config.pem_file
        http.auth.ssl.cert_key_file = CRA.config.pem_file
        http.auth.ssl.verify_mode = :peer 
      end
    end

    def soap_action(name)
      "#{BASE_URL}/#{name}"
    end

  end

end

require 'cra/pasport_info'
require 'cra/services'
