# -*- encoding : utf-8 -*-
require 'singleton'

module CRA

  class Config
    include Singleton
    attr_accessor :user, :password, :test_mode, :cert_file, :cert_password, :cert_trace
    def url
      self.test_mode ? 'https://test.submission.e-government.ge/submission' : 'https://submission.e-government.ge/submission'
    end
  end

  class << self
    def config
      CRA::Config.instance
    end
  end

end
