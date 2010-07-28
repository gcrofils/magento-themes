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

class EavAttribute < ActiveRecord::Base
	set_primary_key "attribute_id" 
end

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
    puts row.inspect
  end
end
  

EavAttribute.find_by_attribute_code('total_weight').inspect
