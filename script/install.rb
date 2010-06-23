#!/usr/bin/ruby

magentoTheme = "webandpeople-fashion"
wwwroot = "/home/www"
magentoCurrent = "magento"
appPath = "app"
skinPath = "skin"

themePath = File.expand_path(File.join(File.dirname(File.join(Dir.getwd, __FILE__)), '..', magentoTheme))
targetPath = File.expand_path(File.join(wwwroot, magentoCurrent))

File.copy(File.join(themePath, appPath), targetPath)