# -*- encoding : utf-8 -*-
# Savon (SOAP client)

require 'savon'

HTTPI.log = false
Savon.configure do |config|
  config.log = false
end

# RSpec

require 'rspec'

RSpec.configure do |config|
  config.include(RSpec::Matchers)
end

# Test options.

require 'cra'

