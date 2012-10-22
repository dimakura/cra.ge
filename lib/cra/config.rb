# -*- encoding : utf-8 -*-
require 'singleton'

module CRA
  class Config
    include Singleton
    attr_accessor :pem_file
  end

  class << self
    def config
      CRA::Config.instance
    end
  end
end
