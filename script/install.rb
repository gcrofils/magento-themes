#!/usr/bin/ruby

require 'ftools'
require 'fileutils'
require 'yaml'


magentoTheme = "webandpeople-fashion"
wwwroot = "/home/www"
magentoCurrent = "magento"
appPath = "app"
skinPath = "skin"

themePath = File.expand_path(File.join(File.dirname(File.join(Dir.getwd, __FILE__)), '..', magentoTheme))
targetPath = File.expand_path(File.join(wwwroot, magentoCurrent))
pagesPath = File.expand_path(File.join(themePath, 'pages'))
blocksPath = File.expand_path(File.join(themePath, 'blocks'))


FileUtils.cp_r File.join(themePath, appPath), targetPath
FileUtils.cp_r File.join(themePath, skinPath), targetPath

Dir["#{blocksPath}/*"].select { |file| /(yaml|yml)$/ =~ file }.each do |file|
  puts file.inspect
  data = YAML.load_file( file )
  puts data.inspect
end





data = YAML.load_file( File.join(pagesPath, 'home.yml' ))
puts data.inspect