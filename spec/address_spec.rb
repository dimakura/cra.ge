# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Find address by name' do
  before(:all) do
    @addresses = CRA.serv.address_by_name(CRA::TBILISI_ID, 'ტაბიძე')
  end
  context do
    subject { @addresses }
    it { should_not be_nil }
    it { should_not be_empty }
    its(:size) { should == 2 }
  end
  context do
    subject { @addresses.first }
    its(:id) { should == 988572 }
    its(:name) { should == 'საქართველო/თბილისი/კრწანისი/გ.ტაბიძე-შ.დადიანის/' }
    its(:old_name) { should be_nil }
    its(:active) { should == true }
  end
  context do
    subject { @addresses.last }
    its(:id) { should == 1989533 }
    its(:name) { should == 'საქართველო/თბილისი/მთაწმინდა/კიკეთი/გ. ტაბიძე/' }
    its(:old_name) { should be_nil }
    its(:active) { should == true }
  end
end
