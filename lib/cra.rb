# -*- encoding : utf-8 -*-
require 'savon'
require 'cra/version'

require 'cra/config'
require 'cra/services'

module CRA
  BASE_URL = 'stateinstitutions.cra.ge'
  WSDL_URL= "https://#{BASE_URL}/Service.asmx?WSDL"

  protected

  def get_client
    Savon::Client.new WSDL_URL do 
      http.auth.ssl.cert_file = CRA.config.pem_file
      http.auth.ssl.cert_key_file = CRA.config.pem_file
      http.auth.ssl.verify_mode = :peer 
    end
  end

  def soap_action(name)
    "http://#{BASE_URL}/#{name}"
  end

end
