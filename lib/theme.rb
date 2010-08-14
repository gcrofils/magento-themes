module MageTheme
  
  class NoClientDefined < StandardError #:nodoc:
  end

  class NoThemeDefined < StandardError #:nodoc:
  end
  
  class Base
    
    def load_yaml(file)
      YAML.load_file(file).each  do |key, value|
        send("#{key}=",value)
      end
    end
    
  end
  
  class Theme < MageTheme::Base
    
    attr_accessor :client, :theme
    
    def initialize(options = {})
      @client = options[:client]
      @theme  = options[:theme]
    end
    
    def install
      raise NoClientDefined if client.nil?
      raise NoThemeDefined if theme.nil?
      upsert_cms(:type => :blocks)
    end
    
    def upsert_cms(options = {})
      path = File.join(MAGE_THEMES, client, theme, options[:type].to_s)
      Dir["#{path}/*"].select { |file| /(yml)$/ =~ file }.each do |file|
        "MageTheme::#{ActiveSupport::Inflector.singularize(options[:type]).capitalize}".constantize.new.install(file)
      end
    end
    
  end
end
