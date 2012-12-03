# -*- encoding : utf-8 -*-
require 'base64'

class CRA::PassportInfo
  DATE_FORMAT = '%Y-%m-%dT%H:%M:%S'

  attr_accessor :doc_id, :doc_type, :doc_description, :doc_status, :doc_status_text
  attr_accessor :is_id_card, :id_card_serial, :id_card_number, :id_card_issuer, :id_card_issue_date, :id_card_valid_date
  attr_accessor :passport_number, :passport_issuer, :passport_issue_date, :passport_valid_date
  attr_accessor :person_id, :social_id, :private_number
  attr_accessor :first_name, :last_name, :middle_name
  attr_accessor :birth_date, :birth_place
  attr_accessor :gender
  attr_accessor :citizenship, :citizenship_code, :second_citizenship, :second_citizenship_code
  attr_accessor :living_place_id, :living_place, :living_place_registration, :living_place_registration_end, :actual_living_place
  attr_accessor :region_id, :region_name
  attr_accessor :response_id, :response_code
  attr_accessor :is_person_dead, :is_document_lost
  attr_accessor :photos

  def self.extract_date(text)
    DateTime.strptime(text.to_s, DATE_FORMAT)
  rescue Exception => ex
  end

  def self.eval_hash(hash)
    if hash['PersonInfo']
      CRA::PassportInfo.init_with_hash(hash)
    elsif hash['ArrayOfPersonInfo']
      CRA::PassportInfo.list_with_hash(hash)
    end
  end

  def self.init_with_hash(hash)
    hash = hash['PersonInfo'] || hash
    passport = CRA::PassportInfo.new
    passport.doc_id = hash['DocumentID'].to_i
    passport.doc_type = hash['DocumentTypeID'].to_i
    passport.doc_description = hash['DocumentDescription']
    passport.doc_status = hash['DocumentStatusEnum']
    passport.doc_status_text = hash['DocumentStatusStr']
    passport.is_id_card = hash['IsIdCard'].downcase == 'true'
    passport.id_card_serial = hash['IdCardSerial']
    passport.id_card_number = hash['IdCardNumber']
    passport.id_card_issuer = hash['IdCardIssuer']
    passport.id_card_issue_date = extract_date(hash['IdCardIssueDate'])
    passport.id_card_valid_date = extract_date(hash['IdCardValidDate'])
    passport.passport_number = hash['PaspNumber'].strip if hash['PaspNumber']
    passport.passport_issuer = hash['PaspIssuer'].strip if hash['PaspIssuer']
    passport.passport_issue_date = extract_date(hash['PaspIssueDate'])
    passport.passport_valid_date = extract_date(hash['PaspValidDate'])
    passport.person_id = hash['PersonID'].to_i
    # passport.social_id = hash[:social_id].to_i
    passport.private_number = hash['PrivateNumber']
    passport.first_name = hash['FirstName']
    passport.last_name = hash['LastName']
    passport.middle_name = hash['MiddleName']
    passport.birth_date = extract_date(hash['BirthDate'])
    passport.birth_place = hash['BirthPlace']
    passport.gender = hash['Gender'].to_i
    passport.citizenship = hash['Citizenship']
    passport.citizenship_code = hash['CitizenshipCode']
    passport.second_citizenship = hash['DoubleCitizenship'].strip if hash['DoubleCitizenship']
    passport.second_citizenship_code = hash['DoubleCitizenshipCode']
    passport.living_place_id = hash['LivingPlaceID'].to_i rescue nil
    passport.living_place = hash['LivingPlace']
    passport.actual_living_place = hash['FaLivingPlace'].strip if hash['FaLivingPlace']
    passport.living_place = passport.living_place.split(' ').join(' ') if passport.living_place
    passport.actual_living_place = passport.actual_living_place.split(' ').join(' ') if passport.actual_living_place
    passport.living_place_registration = extract_date(hash['LivingPlaceRegDate'])
    passport.living_place_registration_end = extract_date(hash['LivingPlaceRegEndDate'])
    passport.region_id = hash['RegionID'].to_i
    passport.region_name = hash['RegionStr']
    passport.response_id = hash['ResponseID'].to_i
    passport.is_person_dead = hash['IsPersonDead'] == 'true'
    passport.is_document_lost = hash['IsDocumentLost'] == 'true'
    passport.photos = []
    if hash['Photos'] and hash['Photos'].is_a?(Array)
      hash['Photos'].each do |photo|
        passport.photos.push(photo['base64Binary'])
      end
    elsif hash['Photos']
      passport.photos.push(hash['Photos']['base64Binary'])
    end
    passport
  end

  def self.list_with_hash(hash)
    documents = []
    hash['ArrayOfPersonInfo']['PersonInfo'].each do |row|
      documents << CRA::PassportInfo.init_with_hash(row)
    end
    documents
  end

  def full_name(opts = {})
    if opts[:with_middle_name]
      "#{first_name} #{last_name} #{middle_name}"
    else
      "#{first_name} #{last_name}"
    end
  end

  # Returns binary content of the photo.
  def binary(index)
    Base64.decode64(self.photos[index])
  end

  def write_photo(index, file = nil)
    File.open(file || 'photo', 'wb') do |file|
      file.write self.binary(index)
    end
  end

end
