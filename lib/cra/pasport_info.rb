# -*- encoding : utf-8 -*-
class CRA::PasportInfo

  attr_accessor :doc_id, :doc_type, :doc_description, :doc_status, :doc_status_text
  attr_accessor :is_id_card, :id_card_serial, :id_card_number, :id_card_issuer, :id_card_issue_date, :id_card_valid_date
  attr_accessor :pasport_number, :passport_issuer, :passport_issue_date, :passport_valid_date
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

  def self.init_with_hash(hash)
    passport = CRA::PasportInfo.new
    passport.doc_id = hash[:document_id].to_i
    passport.doc_type = hash[:document_type_id].to_i
    passport.doc_description = hash[:document_description]    
    passport.doc_status = hash[:document_status_enum]
    passport.doc_status_text = hash[:document_status_str]
    passport.is_id_card = hash[:is_id_card]
    passport.id_card_serial = hash[:id_card_serial]
    passport.id_card_number = hash[:id_card_number]
    passport.id_card_issuer = hash[:id_card_issuer]
    passport.id_card_issue_date = hash[:id_card_issue_date]
    passport.id_card_valid_date = hash[:id_card_valid_date]
    passport.pasport_number = hash[:pasport_number]
    passport.passport_issuer = hash[:passport_issuer]
    passport.passport_issue_date = hash[:passport_issue_date]
    passport.passport_valid_date = hash[:passport_valid_date]
    passport.person_id = hash[:person_id].to_i
    passport.social_id = hash[:social_id].to_i
    passport.private_number = hash[:private_number]
    passport.first_name = hash[:first_name]
    passport.last_name = hash[:last_name]
    passport.middle_name = hash[:middle_name]
    passport.birth_date = hash[:birth_date]
    passport.birth_place = hash[:birth_place]
    passport.gender = hash[:gender].to_i
    passport.citizenship = hash[:citizenship]
    passport.citizenship_code = hash[:citizenship_code]
    passport.second_citizenship = hash[:double_citizenship]
    passport.second_citizenship_code = hash[:double_citizenship_code]
    passport.living_place_id = hash[:living_place_id].to_i
    passport.living_place = hash[:living_place]
    passport.actual_living_place = hash[:fa_living_place]
    passport.living_place = passport.living_place.split(' ').join(' ') if passport.living_place
    passport.actual_living_place = passport.actual_living_place.split(' ').join(' ') if passport.actual_living_place
    passport.living_place_registration = hash[:living_place_reg_date]
    passport.living_place_registration_end = hash[:living_place_reg_end_date]
    passport.region_id = hash[:region_id].to_i
    passport.region_name = hash[:region_str_]
    passport.response_id = hash[:response_id].to_i
    passport.is_person_dead = hash[:is_person_dead]
    passport.is_document_lost = hash[:is_document_lost]
    passport.photos = []
    if hash[:photos].is_a?(Array)
      hash[:photos].each do |photo|
        passport.photos.push(photo[:base64_binary])
      end
    else
      passport.photos.push(hash[:photos][:base64_binary])
    end
    passport
  end

  def full_name(opts = {})
    if opts[:with_middle_name]
      "#{first_name} #{last_name} #{middle_name}"
    else
      "#{first_name} #{last_name}"
    end
  end

end
