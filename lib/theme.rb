require 'fileutils'
require 'patches'

module MageTheme
  
  class NoClientDefined < StandardError #:nodoc:
  end

  class NoThemeDefined < StandardError #:nodoc:
  end
  
  class Base
    
    cattr_accessor :client, :theme, :store_code, :theme_path, :magento_root, :magento_app, :magento_skin, :magento_code
    
    def initialize(options = {})
      @@client = options[:client] unless options[:client].nil?
      @@theme  = options[:theme] unless options[:theme].nil?
      @@store_code = 'default'
      @@theme_path = File.join(MAGE_THEMES,  @@client, @@theme)
      @@magento_root = options[:root] unless options[:root].nil?
      @@magento_app = File.join(@@magento_root, 'app', 'design', 'frontend', 'default', @@theme)
      @@magento_skin = File.join(@@magento_root, 'skin', 'frontend', 'default', @@theme)
      @@magento_code = File.join(@@magento_root, 'app', 'code', 'local', 'Mage')
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
      copy_templates
      copy_app
      config_store
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
      FileUtils.cp File.join(config_path, 'local.xml'), magento_layout
      FileUtils.cp File.join(config_path, 'etc.xml'), File.join(magento_root, 'app', 'etc', "#{client}.xml")
    end
    
    def copy_skin
      FileUtils.makedirs magento_skin
      FileUtils.cp_r File.join(theme_path, 'skin', '.'), magento_skin
    end
    
    def copy_templates
      Dir["#{template_path}/*"].select { |file| /(phtml)$/ =~ file }.each do |file|
        basename = File.basename(file)
        tarpath = File.join(magento_template, File.dirname(filename_to_path(basename)))
        FileUtils.makedirs tarpath
        FileUtils.cp file, File.join(tarpath, File.basename(filename_to_path(basename)))
      end
    end
    
    def copy_app
      Dir["#{app_path}/*"].select { |file| /(php)$/ =~ file }.each do |file|
        parts = File.basename(file).split('_')
        case parts.shift
          when 'block'
            tarpath = File.join(magento_code, parts.shift.capitalize, 'Block', File.dirname(filename_to_path(parts.join('_'))))
        end
        FileUtils.makedirs tarpath
        FileUtils.cp file, File.join(tarpath, parts.last)
      end
    end
    
    def config_store
      @stack = []
      @params = {}
      dfs(YAML.load_file(File.join(config_path, 'core_config_data.yml')))
      @params.each do |path, value|
        value = '' if value.nil?
        row = CoreConfigData.find_by_path(path) || CoreConfigData.new
        row.update_attributes({:scope => 'default', :scope_id => 0, :path => path, :value => value})
        row.save
      end
      
    end
    
    private
    
    def template_path
      File.join(theme_path, 'templates')
    end
    
    def app_path
      File.join(theme_path, 'app')
    end
    
    def config_path
      File.join(theme_path, 'config')
    end
    
    def magento_template
      File.join(magento_app, 'template')
    end
    
    def magento_layout
      File.join(magento_app, 'layout')
    end
    
    def filename_to_path(filename)
      filename.gsub('_', File::Separator)
    end
    
    def dfs(n)
      case n
      when Hash
        n.each do |k,v|
          @stack.push k
          dfs(v)
          @stack.pop
        end
       else
          @params[@stack.join('/')] = n
       end
    end
  end
end




