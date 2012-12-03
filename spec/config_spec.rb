# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CRA.config do
  its(:user) { should_not be_nil }
  its(:password) { should_not be_nil }
  its(:test_mode) { should == true }
  its(:cert_file) { should_not be_nil }
  its(:cert_password) { should_not be_nil }
end
