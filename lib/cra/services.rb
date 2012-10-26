# -*- encoding : utf-8 -*-
require 'singleton'

module CRA

  class Services < CRA::Base
    include Singleton

    # Get service consumer UPN.
    def my_upn
      action_name = 'GetMyUPN'
      soap_action = self.soap_action(action_name)
      response = get_client.request action_name do
        http.headers['SOAPAction'] = soap_action
      end      
      response.to_hash[:get_my_upn_response][:get_my_upn_result]
    end

    # Getting personal information by personal number.
    def by_personal_id(personal_number)
      raise ArgumentError('personal_number required') if personal_number.blank?
      response = process_request('GetDataUsingPrivateNumber', { 'privateNumber' => personal_number })
      CRA::PasportInfo.init_with_hash(response)
    end

    # Getting personal information by ID card information.
    def by_id_card(serial, number)
      raise ArgumentError('id card serial required') if serial.blank?
      raise ArgumentError('id card number required') if serial.blank?
      response = process_request('PersonInfoByDocumentNumber', { 'idCardSerial' => serial, 'idCardNumber' => number })
      CRA::PasportInfo.init_with_hash(response)
    end

    # Getting documents by name and date of birth.
    def list_by_name_and_dob(last_name, first_name, year, month, day)
      raise ArgumentError('first_name required') if first_name.blank?
      raise ArgumentError('last_name required') if last_name.blank?
      raise ArgumentError('year required') if year.blank?
      raise ArgumentError('month required') if month.blank?
      raise ArgumentError('day required') if day.blank?
      response = process_request('GetDataUsingCriteria', { 'lastName' => last_name, 'firstName' => first_name, 'year' => year, 'month' => month, 'day' => day })
      CRA::PasportInfo.list_with_hash(response)
    end

    def test_service
      action_name = 'PersonInfoByDocumentNumber'
      soap_action = self.soap_action(action_name)
      response = get_client.request action_name do
        http.headers['SOAPAction'] = soap_action
        soap.body = { 'idCardSerial' => 'გ', 'idCardNumber' => '1355876' }
      end      
      puts response.to_hash
    end

  end

  class << self
    def serv
      CRA::Services.instance
    end
  end

end
