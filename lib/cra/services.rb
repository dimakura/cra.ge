# -*- encoding : utf-8 -*-
require 'singleton'
require 'rest_client'
require 'active_support/core_ext/hash/conversions'

module CRA
  TBILISI_ID = 4

  class Services < CRA::Base
    include Singleton

    public

    # Returns array of passports.
    def by_name_and_dob(lname, fname, year, month, day)
      body = self.gov_talk_request({
        service: 'GetDataUsingCriteriaParameter',
        message: 'CRAGetDataUsingCriteria',
        class:   'CRAGetDataUsingCriteria',
        params: {
          LastName: lname,
          FirstName: fname,
          Year: year,
          Month: month,
          Day: day,
        }
      })
      CRA::PassportInfo.list_with_hash(body)
    end

    # Returns ID card information.
    def by_id_card(private_number, id_card_serial, id_card_numb)
      body = self.gov_talk_request({
        service: 'GetDataUsingPrivateNumberAndIdCardParameter',
        message: 'GetDataUsingPrivateNumberAndCard',
        class:   'GetDataUsingPrivateNumberAndCard',
        params: {
          PrivateNumber: private_number,
          IdCardSerial: id_card_serial,
          IdCardNumber:  id_card_numb,
        }
      })
      CRA::PassportInfo.init_with_hash(body)
    end

    # Returns passport information.
    def by_passport(private_number, passport)
      body = self.gov_talk_request({
        service: 'FetchPersonInfoByPassportNumberUsingCriteriaParameter',
        message: 'CRA_FetchInfoByPassportCriteria',
        class:   'CRA_FetchInfoByPassportCriteria',
        params: {
          PrivateNumber: private_number,
          Number: passport
        }
      })
      CRA::PassportInfo.init_with_hash(body)
    end

    # Returns array of addresses (ids, names and activity).
    def address_by_name(parent_id, name)
      body = self.gov_talk_request({
        service: 'AddrFindeAddressByNameParameter',
        message: 'CRA_AddrFindeAddressByName',
        class:   'CRA_AddrFindeAddressByName',
        params: {
          Id: parent_id,
          Word: name,
        }
      })
      CRA::Address.list_from_hash(body['ArrayOfResults']['Results'])
    end

  end

  class << self
    def serv
      CRA::Services.instance
    end
  end

end
