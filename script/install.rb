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

magentoTheme = "delhaye"
wwwroot = "/home/www"
magentoCurrent = "magento"
appPath = "app"
skinPath = "skin"

themePath = File.expand_path(File.join(File.dirname(File.join(Dir.getwd, __FILE__)), '..', magentoTheme))
targetPath = File.expand_path(File.join(wwwroot, magentoCurrent))
pagesPath = File.expand_path(File.join(themePath, 'pages'))
blocksPath = File.expand_path(File.join(themePath, 'blocks'))

def execSql(sql)
 cmd = "mysql -u#{MYSQL_USER} -p#{MYSQL_PASSWORD} -e \"connect #{MYSQL_DATABASE}; #{sql.gsub('"','\"')}; \""
 system "#{cmd}" 
 #puts "#{cmd}" 
end

FileUtils.cp_r File.join(themePath, appPath), targetPath
FileUtils.cp_r File.join(themePath, skinPath), targetPath

queries = Array.new

paths = {'page' => pagesPath, 'block' => blocksPath}

%w[page block].each do |t|

  Dir["#{paths[t]}/*"].select { |file| /(yml)$/ =~ file }.each do |file|
    identifier = File.basename(file, ".yml")
    queries << "delete from cms_#{t} where identifier='#{identifier}'"
    params = YAML.load_file( file )
    params['identifier'] = identifier
  
    values = params.values.map{|v| v.is_a?(String) ? "'#{v}'" : (v.nil? ? 'NULL' : v)}
    values << 'now()'
    values << 'now()'
  
    keys = params.keys
    keys << 'creation_time'
    keys << 'update_time'
      
    queries << "insert into cms_#{t} (#{keys.join(',')}) values (#{values.join(',')})"
    queries << "insert into cms_#{t}_store (store_id, #{t}_id) select 1, #{t}_id from cms_#{t} where identifier = '#{identifier}'"
  end

end

queries.each{|q| execSql(q)}