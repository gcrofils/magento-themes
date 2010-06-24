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
blocsPath = File.expand_path(File.join(themePath, 'blocs'))


FileUtils.cp_r File.join(themePath, appPath), targetPath
FileUtils.cp_r File.join(themePath, skinPath), targetPath


data = YAML.load_file( File.join(blocsPath, 'left_info.yml' ))
puts data.inspect