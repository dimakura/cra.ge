# -*- encoding : utf-8 -*-
require 'cra/version'
require 'cra/config'

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

module CRA
  MALE = 1
  FEMALE = 2

  class ServiceException < Exception
  end

end

require 'cra/base'
require 'cra/passport_info'
require 'cra/address'
require 'cra/address_info'
require 'cra/services'
