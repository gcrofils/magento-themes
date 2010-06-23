#!/usr/bin/ruby

require 'ftools'
require 'fileutils'

magentoTheme = "webandpeople-fashion"
wwwroot = "/home/www"
magentoCurrent = "magento"
appPath = "app"
skinPath = "skin"

themePath = File.expand_path(File.join(File.dirname(File.join(Dir.getwd, __FILE__)), '..', magentoTheme))
targetPath = File.expand_path(File.join(wwwroot, magentoCurrent))

FileUtils.cp_r File.join(themePath, appPath), targetPath
FileUtils.cp_r File.join(skinPath, appPath), targetPath