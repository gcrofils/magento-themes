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
	#set_table_name "FooBar" 
	set_primary_key "attribute_id" 
end

puts EavAttribute.count


####
rows = Array.new
open(url) do |f|
  firstline = true
  f.each_line do |line|
    FasterCSV.parse(line) do |row|
      headers = row if firstline
      firstline = false
      rows << row
    end
  end
end

puts rows.inspect
