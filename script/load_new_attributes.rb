#!/usr/bin/ruby

spreadsheet_key = "0Ai-hiZBisabCdGhlSkk4UTRoNlAzcjIxbldDVk8xZ2c"
uri_attributes = "http://spreadsheets.google.com/pub?key=#{spreadsheet_key}&hl=fr&single=true&gid=2&output=csv"

require 'rubygems'
require 'active_record'
require 'open-uri'
require 'csv'


ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql',
  :database => 'magento',
  :username => 'magentouser',
  :password => 'magento09',
  :host     => 'localhost')

ActiveRecord::Base.logger = Logger.new(File.open('/home/ubuntu/database.log', 'a'))

ActiveRecord::Base.pluralize_table_names = false

load 'activerecord_classes.rb'


def loadDatas(uri)
 begin
  CSV.parse(open(uri).read)
 rescue
  Array.new
 end
end

firstrow = true
loadDatas(uri_attributes).each do |row|
  if firstrow
    attributes = row 
    firstrow = false
  else
    sku = row.shift
    product = CatalogProductEntity.find_by_sku(sku)
    unless product.nil?
      (1..row.count).each do |i|
        eavAttribute = EavAttribute.find_by_attribute_code(attributes[i])
        case eavAttribute.backend_type
          when 'varchar'
            CatalogProductEntityVarchar.create(:entity_type_id => 4, :attribute_id => eavAttribute.id, :store_id => 0, :entity_id => product.entity_id, :value => row[i])
          when 'int'
            option = EavAttributeOptionValue.find_by_value(row[i])
            if option.nil
              puts "option #{row[i]} inconnue"
            else
              CatalogProductEntityInt.create(:entity_type_id => 4, :attribute_id => eavAttribute.id, :store_id => 0, :entity_id => product.entity_id, :value => option.id)
            end
        end
      end
    end
  end
end
  

