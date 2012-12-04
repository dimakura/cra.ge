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

class CRA::AddressNode
  attr_accessor :id, :description, :description_full, :address
  attr_accessor :identificator, :identificator_text
  attr_accessor :identificator_type, :identificator_type_text
  attr_accessor :active

  def self.list_from_hash(hash)
    nodes = []
    hash.each do |res|
      node = CRA::AddressNode.new
      node.id = res['ID'].to_i
      node.description = res['Description']
      node.description_full = res['FullDescription']
      node.identificator = res['Identificator'].to_i
      node.identificator_text = res['IdentificatorStr']
      node.identificator_type = res['IdentificatorType'].to_i
      node.identificator_type_text = res['IdentificatorTypeStr']
      node.address = res['NodeAdress']
      node.active = res['Status'].to_i == 1
      nodes << node
    end
    nodes
  end

end
