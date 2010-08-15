require 'fileutils'
require 'patches'

module MageTheme
  
  class NoClientDefined < StandardError #:nodoc:
  end

  class NoThemeDefined < StandardError #:nodoc:
  end
  
  class Base
    
    cattr_accessor :client, :theme, :store_code, :theme_path, :magento_root, :magento_app, :magento_skin
    
    def initialize(options = {})
      @@client = options[:client] unless options[:client].nil?
      @@theme  = options[:theme] unless options[:theme].nil?
      @@store_code = 'default'
      @@theme_path = File.join(MAGE_THEMES,  @@client, @@theme)
      @@magento_root = '/home/www/magento'
      @@magento_app = File.join(@@magento_root, 'app', 'design', 'frontend', 'default', @@theme)
      @@magento_skin = File.join(@@magento_root, 'skin', 'frontend', 'default', @@theme)
    end
    
    def store_id
      @store ||= CoreStore.find_by_code(store_code)
      @store.id
    end
    
    def load_yaml(file)
      YAML.load_file(file).each  do |key, value|
        send("#{key}=",value)
      end
    end
    
  end
  
  class Theme < MageTheme::Base
    
    def install
      raise NoClientDefined if client.nil?
      raise NoThemeDefined if theme.nil?
      update_local_xml
      upsert_cms(:type => :blocks)
      upsert_cms(:type => :pages)
      copy_skin
      force_design_change
    end
    
    def upsert_cms(options = {})
      path = File.join(theme_path, options[:type].to_s)
      Dir["#{path}/*"].select { |file| /(yml)$/ =~ file }.each do |file|
        "MageTheme::#{ActiveSupport::Inflector.singularize(options[:type]).capitalize}".constantize.new.install(file)
      end
    end
    
    def force_design_change
      DesignChange.delete_all
      DesignChange.create(:store_id => store_id, :design => "default/#{theme}")
    end
    
    def update_local_xml
      FileUtils.makedirs File.join(magento_app, 'layout')
      FileUtils.cp File.join(theme_path, 'config', 'local.xml'), File.join(magento_app, 'layout')
      logger.debug "MageTheme::Theme.update_local_xml copy #{File.join(theme_path, 'config', 'local.xml')} to #{File.join(magento_app, 'layout')}"
    end
    
    def copy_skin
      FileUtils.makedirs magento_skin
      FileUtils.cp_r File.join(theme_path, 'skin'), magento_skin
    end
  end
end
