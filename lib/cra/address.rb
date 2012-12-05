# -*- encoding : utf-8 -*-
class CRA::Address
  attr_accessor :id, :name, :old_name, :active

  def self.list_from_hash(hash)
    addresses = []
    hash.each do |res|
      address = CRA::Address.new
      address.id = res['ID'].to_i
      address.name = res['Name']
      address.old_name = res['OldName']
      address.active = res['Status'] == 'true'
      addresses << address
    end
    addresses
  end

end
