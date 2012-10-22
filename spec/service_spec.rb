# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'cra'

describe 'get person info by id' do
  before(:all) do
    @person_info = CRA.serv.by_personal_id('02001000490')
  end
  subject { @person_info }
  its(:doc_id) { should > 0 }
  its(:doc_type) { should == 1 }
  its(:doc_description) { should == 'პირადობის მოწმობა' }
  its(:doc_status) { should == 'Active' }
  its(:doc_status_text) { should == 'აქტიური' }
  its(:is_id_card) { should == true }
  its(:id_card_serial) { should == 'გ' }
  its(:id_card_number) { should == '1355876' }
  its(:id_card_issuer) { should == 'სამოქალაქო რეესტრის სააგენტოს მთაწმინდა-კრწანისის სამსახური' }
  its(:id_card_issue_date) { should_not be_nil }
  its(:id_card_valid_date) { should_not be_nil }
  its(:pasport_number) { should be_nil }
  its(:passport_issuer) { should be_nil }
  its(:passport_issue_date) { should be_nil }
  its(:passport_valid_date) { should be_nil }
  its(:person_id) { should == 969036 }
  its(:private_number) { should == '02001000490' }
  its(:first_name) { should == 'დიმიტრი' }
  its(:last_name) { should == 'ყურაშვილი' }
  its(:middle_name) { should == 'ალბერტი' }
  its(:birth_date) { should_not be_nil }
  its(:birth_place) { should == 'საქართველო, აბაშა' }
  its(:gender) { should == CRA::MALE }
  its(:citizenship) { should == 'საქართველო' }
  its(:citizenship_code) { should == 'GEO' }
  its(:second_citizenship) { should be_nil }
  its(:second_citizenship_code) { should be_nil }
  its(:living_place_id) { should == 920434 }
  its(:living_place) { should == 'თბილისი მისამართის გარეშე' }
  its(:living_place_registration) { should_not be_nil }
  its(:living_place_registration_end) { should be_nil }
  its(:actual_living_place) { should == 'თბილისი აკ.ხორავას ჩიხი N 8' }
  its(:is_person_dead) { should == false }
  its(:is_document_lost) { should == false }
end

# describe 'get person info by id' do
#   before(:all) do
#     @person_info = CRA.serv.by_personal_id('01024022592')
#   end
#   subject { @person_info }
#   its(:first_name) { should == 'თამარ' }
#   its(:last_name) { should == 'ვარსიმაშვილი' }
#   its(:gender) { should == CRA::FEMALE }
#   its(:citizenship) { should == 'საქართველო' }
#   its(:citizenship_code) { should == 'GEO' }
#   its(:second_citizenship) { should be_nil }
#   its(:second_citizenship_code) { should be_nil }
# end

describe 'find person documents by name and dob' do
  before(:all) do
    @documents = CRA.serv.by_name_and_dob('ყურაშვილი', 'დიმიტრი', 1979, 4, 4)
  end
  subject { @documents }
  its(:size) { should == 5 }
  #its(:person_id) { should == 969036 }
  #its(:private_number) { should == '02001000490' }
end