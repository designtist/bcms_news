class RecentNewsPortlet < Cms::Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false
  
  def render
    order = "release_date DESC"
    if !self.sort_by.blank? and !self.sort_order.blank?
      order = "#{self.sort_by} #{self.sort_order}"
    end

    if self.category_id.blank?
      @articles = BcmsNews::NewsArticle.released.all(:order => order, :limit => self.limit)
    else
      @category = Cms::Category.find(self.category_id)
      @articles = BcmsNews::NewsArticle.released.all(:conditions => ["category_id = ?", @category.id], 
          :order => order, :limit => self.limit)
    end
  end

end