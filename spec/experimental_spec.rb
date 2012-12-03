# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'cra'

describe 'test' do
  before(:all) do
    CRA.serv.test_service
  end
  subject { true }
  it { should == true }
end
