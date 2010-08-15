module MageTheme
  class Block < MageTheme::Base
    
    attr_accessor :title, :is_active, :content
    
    def install(file)
      identifier = File.basename(file, ".yml")
      cmsblock = CmsBlock.find_by_identifier(identifier) || CmsBlock.new(:identifier => identifier)
      load_yaml(file)
      cmsblock.update_attributes(
        :title => title,
        :is_active => is_active,
        :content => content,
        :update_time => Time.now,
        :creation_time => cmsblock.creation_time || Time.now,
        :core_store_ids => [CoreStore.find_by_code('default').id]
      )

    end
  end
end