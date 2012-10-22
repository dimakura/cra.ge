# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'configure CRA gem' do
  specify { CRA.config.pem_file.should == 'spec/data/telasi.pem' }
end
