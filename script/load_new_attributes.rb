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
logger = ActiveRecord::Base.logger

ActiveRecord::Base.pluralize_table_names = false

load 'activerecord_classes.rb'


def loadDatas(uri)
 begin
  CSV.parse(open(uri).read)
 rescue
 puts "WARNING : no data"

  Array.new
 end
end

firstrow = true
attributes = Array.new
unknown_options = {}
j=0
loadDatas(uri_attributes).each do |row|
  if firstrow
    attributes = row 
    firstrow = false
  else
    j+=1
    sku = row[0] 
    puts "#{j} == #{sku}"
    product = CatalogProductEntity.find_by_sku(sku)
    unless product.nil?
      (1..row.size).each do |i|
        row[i] = row[i].strip
	unless row[i].nil?		
          eavAttribute = EavAttribute.find_by_attribute_code(attributes[i])
          unless eavAttribute.nil? 
            case eavAttribute.backend_type
              when 'varchar'
                begin
                  CatalogProductEntityVarchar.create(:entity_type_id => 4, :attribute_id => eavAttribute.id, :store_id => 0, :entity_id => product.entity_id, :value => row[i])
                rescue Exception => e
                  puts "WARNING : #{e.message}"
                end
              when 'int'
                option = EavAttributeOptionValue.find_by_value(row[i])
                if option.nil?
                  puts "WARNING : option #{row[i]} inconnue pour l'attribut #{attributes[i]}"
		  unknown_options[attributes[i]] = Array.new if unknown_options[attributes[i]].nil? 
                  unknown_options[attributes[i]] << row[i]	
                else
                  begin
                    CatalogProductEntityInt.create(:entity_type_id => 4, :attribute_id => eavAttribute.id, :store_id => 0, :entity_id => product.entity_id, :value => option.id)
		  rescue Exception => e
                    puts "WARNING : #{e.message}"
                  end
                end
	      else
                puts "WARNING : type inconnu #{eavAttribute.backend_type}"
              end
          else
	    puts "WARNING : >#{attributes[i]}< not found"
          end
        end
      end
    end
  end
end

