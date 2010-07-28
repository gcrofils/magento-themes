#!/usr/bin/ruby

spreadsheet_key = "0Ai-hiZBisabCdGhlSkk4UTRoNlAzcjIxbldDVk8xZ2c"
uri_attributes = "http://spreadsheets.google.com/pub?key=#{spreadsheet_key}&hl=fr&single=true&gid=1&output=csv"

require 'rubygems'
require 'active_record'
require 'open-uri'
require 'faster_csv'


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

####
rows = Array.new
open(uri_attributes) do |f|
  firstline = true
  f.each_line do |line|
    FasterCSV.parse(line) do |row|
      headers = row if firstline
      rows << row unless firstline
      firstline = false
    end
  end
end

rows.each do |row|
  puts row.inspect
end

EavAttribute.find_by_attribute_code('total_weight').inspect
