# -*- encoding : utf-8 -*-
require 'singleton'

module CRA

  class Services < CRA::Base
    include Singleton

    # Getting personal information by personal number.
    def by_personal_id(personal_number)
      raise ArgumentError('personal_number required') if personal_number.blank?
      action_name = 'GetDataUsingPrivateNumber'
      soap_action = self.soap_action(action_name)
      response = get_client.request action_name do
        http.headers['SOAPAction'] = soap_action
        soap.body = { 'privateNumber' => personal_number }
      end      
      CRA::PasportInfo.init_with_hash(response.to_hash[:get_data_using_private_number_response][:get_data_using_private_number_result])
    end

    def list_by_name_and_dob(last_name, first_name, year, month, day)
      raise ArgumentError('first_name required') if first_name.blank?
      raise ArgumentError('last_name required') if last_name.blank?
      raise ArgumentError('year required') if year.blank?
      raise ArgumentError('month required') if month.blank?
      raise ArgumentError('day required') if day.blank?
      action_name = 'GetDataUsingCriteria'
      soap_action = self.soap_action(action_name)
      response = get_client.request action_name do
        http.headers['SOAPAction'] = soap_action
        soap.body = { 'lastName' => last_name, 'firstName' => first_name, 'year' => year, 'month' => month, 'day' => day }
      end
      data = response.to_hash[:get_data_using_criteria_response][:get_data_using_criteria_result][:person_info]
      documents = []
      data.each do |row|
        documents << CRA::PasportInfo.init_with_hash(row)
      end
      documents
    end

  end

  class << self
    def serv
      CRA::Services.instance
    end
  end

end
