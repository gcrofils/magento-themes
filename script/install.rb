#!/usr/bin/ruby

require 'ftools'
require 'fileutils'
require 'yaml'

#MYSQL_DATABASE  = '<database>'
#MYSQL_USER      = '<user>'
#MYSQL_PASSWORD  = '<password>'
#TRACE_LOG       = '<tracefile>'

MYSQL_DATABASE  = 'magento'
MYSQL_USER      = 'magentouser'
MYSQL_PASSWORD  = 'magento09'
TRACE_LOG       = '/home/ubuntu/test.log'

magentoTheme = "webandpeople-fashion"
wwwroot = "/home/www"
magentoCurrent = "magento"
appPath = "app"
skinPath = "skin"

themePath = File.expand_path(File.join(File.dirname(File.join(Dir.getwd, __FILE__)), '..', magentoTheme))
targetPath = File.expand_path(File.join(wwwroot, magentoCurrent))
pagesPath = File.expand_path(File.join(themePath, 'pages'))
blocksPath = File.expand_path(File.join(themePath, 'blocks'))

def execSql(sql)
 cmd = "mysql -u#{MYSQL_USER} -p#{MYSQL_PASSWORD} -e \"connect #{MYSQL_DATABASE}; #{sql}; \""
 puts "#{cmd}" 
end

FileUtils.cp_r File.join(themePath, appPath), targetPath
FileUtils.cp_r File.join(themePath, skinPath), targetPath

queries = Array.new

Dir["#{blocksPath}/*"].select { |file| /(yml)$/ =~ file }.each do |file|
  identifier = File.basename(file, ".yml")
  queries << "delete from cms_block where identifier='#{identifier}'"
  params = YAML.load_file( file )
  params['identifier'] = identifier
  queries << "insert into cms_block (#{params.keys.join(',')}) values ('#{params.values.join('\',\'')}')"
end

Dir["#{pagesPath}/*"].select { |file| /(yml)$/ =~ file }.each do |file|
  identifier = File.basename(file, ".yml")
  queries << "delete from cms_page where identifier='#{identifier}'"
  params = YAML.load_file( file )
  params['identifier'] = identifier
  queries << "insert into cms_page (#{params.keys.join(',')}) values ('#{params.values.join('\',\'')}')"
end

queries.each{|q| execSql(q)}