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
    end

  end

  class << self
    def serv
      CRA::Services.instance
    end
  end

end
