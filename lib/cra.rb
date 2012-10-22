# -*- encoding : utf-8 -*-
require 'savon'
require 'cra/version'

require 'cra/config'
require 'cra/services'

module CRA
  BASE_URL = 'stateinstitutions.cra.ge'
  WSDL_URL= "https://#{BASE_URL}/Service.asmx?WSDL"
end
