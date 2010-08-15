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
        :store_ids => 1
      )
      
      #cmsblockstore = CmsBlockStore.find(:first, :conditions => {:store_id => 1, :block_id => cmsblock.id})
      #if cmsblockstore.nil?
      #  CmsBlockStore.create(:store_id => 1, :block_id => cmsblock.id)
      #end

    end
  end
end