# -*- encoding : utf-8 -*-

# RSpec

require 'rspec'

RSpec.configure do |config|
  config.include(RSpec::Matchers)
end

# Test options.

require 'cra'
require 'spec_helper_private'
