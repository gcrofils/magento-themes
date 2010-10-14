require 'fileutils'
require 'patches'

module MageTheme
  
  class NoClientDefined < StandardError #:nodoc:
  end

  class NoThemeDefined < StandardError #:nodoc:
  end
  
  class Base
    
    cattr_accessor :client, :theme, :store_code, :theme_path, :magento_root, :magento_app, :magento_skin, :magento_code, :magento_email
    
    def initialize(options = {})
      @@client = options[:client] unless options[:client].nil?
      @@theme  = options[:theme] unless options[:theme].nil?
      @@store_code = 'default'
      @@theme_path = File.join(MAGE_THEMES,  @@client, @@theme)
      @@magento_root = options[:root] unless options[:root].nil?
      @@magento_app = File.join(@@magento_root, 'app', 'design', 'frontend', 'default', @@theme)
      @@magento_skin = File.join(@@magento_root, 'skin', 'frontend', 'default', @@theme)
      @@magento_code = File.join(@@magento_root, 'app', 'code', 'local')
      @@magento_template = File.join(@@magento_root, 'app', 'locale', 'fr_FR', 'template')
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
      copy_locales
      copy_emails
      config_store
      force_design_change
      chown_chmod
    end
    
    private
    
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
            tarpath = File.join(magento_code, 'Mage', parts.shift.capitalize, 'Block', File.dirname(filename_to_path(parts.map{|p| p.capitalize}.join('_'))))
          when 'hack'
            tarpath = File.join(magento_code, File.dirname(filename_to_path(parts.map{|p| p.capitalize}.join('_'))))
        end
        FileUtils.makedirs tarpath
        FileUtils.cp file, File.join(tarpath, parts.last.capitalize)
        puts File.join(tarpath, parts.last.capitalize)
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
    
    def copy_locales
      Dir["#{locale_path}/*"].select { |file| /(csv)$/ =~ file }.each do |file|
        locale = File.basename(file, '.csv')
        FileUtils.makedirs File.join(magento_locale, locale)
        FileUtils.cp file, File.join(magento_locale, locale, 'translate.csv')
      end
    end
    
    def copy_emails
      FileUtils.cp_r email_path, magento_template
    end
    
    def template_path
      File.join(theme_path, 'templates')
    end
    
    def app_path
      File.join(theme_path, 'app')
    end
    
    def locale_path
       File.join(theme_path, 'skin', 'locale')
     end
    
    def config_path
      File.join(theme_path, 'config')
    end
    
    def email_path
      File.join(theme_path, 'email')
    end
    
    def magento_template
      File.join(magento_app, 'template')
    end
    
    def magento_layout
      File.join(magento_app, 'layout')
    end
    
    def magento_locale
      File.join(magento_app, 'locale')
    end
    
    def filename_to_path(filename)
      filename.gsub('_', File::Separator)
    end
    
    def magento_media
      File.join(magento_root, 'media')
    end
    
    def magento_var
      File.join(magento_root, 'var')
    end
    
    def chown_chmod
      FileUtils.chown_R Etc.getpwuid(File.stat(magento_root).uid).name, Etc.getgrgid(File.stat(magento_root).gid).name, "#{magento_root}/"
      FileUtils.chmod_R 0777, magento_media
      FileUtils.chmod_R 0777, magento_var
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




