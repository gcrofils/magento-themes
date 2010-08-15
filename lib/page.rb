module MageTheme
  class Page < MageTheme::Base
    
    attr_accessor :title, :root_template, :meta_keywords, :meta_description, :content_heading, :content, :layout_update_xml, :is_active
    
    def install(file)
      identifier = File.basename(file, ".yml")
      cmspage = CmsPage.find_by_identifier(identifier) || CmsPage.new(:identifier => identifier)
      load_yaml(file)
      cmspage.update_attributes(
        :title => title,
        :root_template => root_template,
        :meta_keywords => meta_keywords,
        :meta_description => meta_description,
        :content_heading => content_heading,
        :content => content,
        :layout_update_xml => layout_update_xml,
        :is_active => is_active,
        :update_time => Time.now,
        :creation_time => cmspage.creation_time || Time.now,
        :core_store_ids => [store_id]
      )

    end
  end
end