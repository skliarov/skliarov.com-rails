class AddPublishedAtToArticles < ActiveRecord::Migration[4.2]
  def self.up
    add_column :articles, :published_at, :datetime

    for article in Article.all do
      if article.published
        article.published_at = article.created_at
        article.save
      end
    end

    remove_column :articles, :published
  end

  def self.down
    add_column :articles, :published, :boolean, default: false

    for article in Article.all do
      if article.published_at
        article.published = true
        article.save
      end
    end

    remove_column :articles, :published_at
  end
end
