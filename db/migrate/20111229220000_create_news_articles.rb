class CreateNewsArticles < ActiveRecord::Migration
  def self.up
    create_versioned_table :news_articles do |t|
      t.string :name 
      t.string :slug
      t.datetime :release_date 
      t.belongs_to :category 
      t.text :summary, :size => (64.kilobytes + 1) 
      t.text :body, :size => (64.kilobytes + 1) 
    end
  end

  def self.down
    Cms::ContentType.delete_all(['name = ?', 'NewsArticle'])
    Cms::CategoryType.all(:conditions => ['name = ?', 'News Article']).each(&:destroy)
    drop_table :news_release_versions
    drop_table :news_releases
  end
end
