# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'configure CRA gem' do
  before(:all) do
    CRA.config.pem_file = 'telasi.pem'
  end
  specify { CRA.config.pem_file.should == 'telasi.pem' }
end
