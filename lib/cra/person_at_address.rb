# -*- encoding : utf-8 -*-
class CRA::PersonAtAddress
  attr_accessor :first_name, :last_name, :birth_date, :active, :status_text, :gender, :address, :private_number

  def self.extract_date(text)
    DateTime.strptime(text.to_s, '%d/%m/%Y')
    #rescue Exception => ex
  end

  def self.init_with_hash(hash)
    hash = hash['PersonsAtAddress'] || hash
    person = CRA::PersonAtAddress.new
    person.first_name = hash['MD_FIRST']
    person.last_name = hash['MD_LAST']
    person.birth_date = CRA::PersonAtAddress.extract_date(hash['MD_BIRTH_DATE'])
    person.status_text = hash['APPD_STATUS_DESCRIPTION']
    person.active = person.status_text == 'აქტიური'
    person.gender = hash['MD_GENDER_STR']
    person.address = hash['OA_RP_FULL_ADDRESS']
    person.private_number = hash['PN_PRIVATE_NUMBER']
    person
  end

  def self.list_from_hash(hash)
    persons = []
    hash = hash['PersonsAtAddress']
    if hash.is_a? Array
      hash.each do |row|
        persons << CRA::PersonAtAddress.init_with_hash(row)
      end
    else
      persons << CRA::PersonAtAddress.init_with_hash(hash)
    end
    persons
  end

end
