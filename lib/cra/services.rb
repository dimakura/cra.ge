# -*- encoding : utf-8 -*-
require 'singleton'
require 'rest_client'
require 'active_support/core_ext/hash/conversions'

module CRA
  ROOT_ID    = 0
  GEORGIA_ID = 1
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

    # Returns array of addresses.
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

    # Getting address root.
    def address_root
      body = self.gov_talk_request({
        message: 'CRA_AddrGetRootNode',
        class:   'CRA_AddrGetRootNode',
        params: {}
      })
      CRA::AddressNode.list_from_hash(body['ArrayOfNodeInfo']['NodeInfo'])
    end

    # Returns array of address nodes.
    def address_by_parent(parent_id)
      body = self.gov_talk_request({
        message: 'CRA_AddrGetNodesByParentID',
        class:   'CRA_AddrGetNodesByParentID',
        params: {
          long: parent_id,
        }
      })
      CRA::AddressNode.list_from_hash(body['ArrayOfNodeInfo']['NodeInfo'])
    end

    # Get address info by it's id.
    def address_info(id)
      body = self.gov_talk_request({
        message: 'CRA_AddrGetAddressInfoByID',
        class:   'CRA_AddrGetAddressInfoByID',
        params: {
          long: id,
        }
      })
      # puts body.to_s
      CRA::AddressInfo.init_from_hash(body['AddressInfo'])
    end

    # Get persons array at the given address. 
    def persons_at_address(address_id)
      body = self.gov_talk_request({
        message: 'CRA_GetPersonsAtAddress',
        class:   'CRA_GetPersonsAtAddress',
        params: {
          long: address_id,
        }
      })
      CRA::PersonAtAddress.list_from_hash(body['ArrayOfPersonsAtAddress'])
    end

  end

  class << self
    def serv
      CRA::Services.instance
    end
  end

end
