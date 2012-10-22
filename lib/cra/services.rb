# -*- encoding : utf-8 -*-
require 'singleton'

module CRA

  class Services
    include Singleton

    # Getting personal information by personal ID.
    def by_personal_id(person_id)
      raise ArgumentError('person_id required') if person_id.blank?
      action_name = 'GetDataUsingPrivateNumber'
      response = get_client.request action_name do
        http.headers['SOAPAction'] = soap_action(action_name)
        soap.body = { 'privateNumber' => person_id }
      end
    end

  end

  class << self
    def serv
      CRA::Services.instance
    end
  end

end
