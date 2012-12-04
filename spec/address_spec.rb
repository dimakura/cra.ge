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

describe 'Find address by parent id' do
  before(:all) do
    @nodes = CRA.serv.address_by_parent(CRA::TBILISI_ID)
  end
  context do
    subject { @nodes }
    it { should_not be_nil }
    it { should_not be_empty }
    its(:size) { should == 11 }
  end
  context do
    subject { @nodes.first }
    its(:id) { should == 191 }
    its(:description) { should == 'გლდანი' }
    its(:description_full) { should == 'გლდანი' }
    its(:identificator) { should == 32 }
    its(:identificator_text) { should == 'ქალაქის რაიონი' }
    its(:identificator_type) { should == 1 }
    its(:identificator_type_text) { should == 'ჩვეულებრივი' }
    its(:address) { should == 'თბილისი' }
    its(:active) { should == true }
  end
end
