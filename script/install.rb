#!/usr/bin/ruby

require 'ftools'
require 'fileutils'
require 'yaml'
require 'getoptlong'

opts = GetoptLong.new(
    [ "--theme",             "-t",   GetoptLong::REQUIRED_ARGUMENT ],
    [ "--version",          "-v",   GetoptLong::NO_ARGUMENT ]
    )
    

  
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

begin
  opts.each do |opt, arg|
  	case opt
  	  when "--version"
        print $0, ", version ", version, "\n"
        exit(0)
      when "--theme"
        magentoTheme = arg.strip
        puts "setup magentoTheme #{magentoTheme}"
    end
  end
rescue
end

themePath = File.expand_path(File.join(File.dirname(File.join(Dir.getwd, __FILE__)), '..', magentoTheme))
targetPath = File.expand_path(File.join(wwwroot, magentoCurrent))
pagesPath = File.expand_path(File.join(themePath, 'pages'))
blocksPath = File.expand_path(File.join(themePath, 'blocks'))
emailsPath = File.expand_path(File.join(themePath, 'emails'))

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

# force design change

queries << "delete from design_change"
queries << "insert into design_change(store_id, design) values (1, '#{magentoTheme}/default')"

queries << "insert into core_config_data(scope, scope_id, path, value) values ('default', 0, 'general/store_information/phone', '01 02 03 04 05') on duplicate key update value = '01 02 03 04 05'"

# Remove cache 
queries << "update core_cache_option set value=0"

# emails
# Load Commons vars
emailVars = YAML.load_file(File.join(emailsPath, 'common.yml'))
emailVarsPattern = /(<<(#{emailVars.keys.join('|')})>>)/ 
puts emailVarsPattern.inspect
Dir["#{emailsPath}/*"].select { |file| /(template\.yml)$/ =~ file }.each do |file|
  identifier = File.basename(file, "_template.yml")
  puts file.inspect
  params = YAML.load_file( file )
  params['template_code'] = identifier if params['template_code'].nil?
  
  values = Array.new
  keys = Array.new
  
  %w[ template_code template_text template_styles template_type template_subject template_sender_name template_sender_email ].each do |var|
    if params[var].is_a?(String)
      values << "'#{params[var].gsub(emailVarsPattern){|match| emailVars[$1]}}'"
    else
      values << params[var].is_a?(String) ? "'#{params[var]}'" : (params[var].nil? ? 'NULL' : params[var])
    end
    keys << var
  end
  
  values << 'now()'
  values << 'now()'
  keys << 'added_at'
  keys << 'modified_at'
  
  queries << "delete from core_email_template where template_code='#{params['template_code']}'"
  queries << "insert into core_email_template (#{keys.join(',')}, orig_template_code, orig_template_variables) values (#{values.join(',')}, '', '')"
  sSQL = "Select template_id from core_email_template where template_code = '#{params['template_code']}'"
  queries << "insert into core_config_data(scope, scope_id, path, value) select 'default', 0, '#{params['core_config_data_path']}', template_id from core_email_template where template_code = '#{params['template_code']}' on duplicate key update value = (#{sSQL})"

end

  

queries.each{|q| execSql(q)}

# Modules
designTarget = File.expand_path(File.join(wwwroot, magentoCurrent, 'app', 'design', 'frontend', magentoTheme))
####
#### ATTENTION ######
#### 
#### Patch : version des modules en dur !
#### 
%w[ AW_Blog-1.0.19 magento_easy_tabs-1.1 ].each do |m|
  src = File.expand_path(File.join(wwwroot, magentoCurrent, 'downloader', 'pearlib', 'download', m, 'frontend', 'default', 'default'))
  FileUtils.cp_r(src, designTarget)
end