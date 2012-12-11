# -*- encoding : utf-8 -*-
class CRA::AddressInfo
  attr_accessor :id, :address, :path, :region_id, :region_name

  def self.init_from_hash(hash)
    address = CRA::AddressInfo.new
    address.id = hash['ID'].to_i
    address.address = hash['Name']
    address.path = hash['Path'].split('|').map{ |p| p.to_i }
    address.region_id = hash['RegionID'].to_i
    address.region_name = hash['RegionName']
    address
  end

end
