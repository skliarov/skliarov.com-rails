class ChangeArticlesPublishingAndSorting < ActiveRecord::Migration[4.2]
  def change
    # Add position column
    add_column :articles, :position, :integer
    add_index :articles, :position
    
    # Add published column
    add_column :articles, :published, :boolean, default: false
    add_index :articles, :published
    
    # Set new fields for Articles
    Article.where.not(published_at: nil).order('published_at ASC').each_with_index do |article, index|
      article.published = true
      article.position = index + 1
      article.save
    end
    
    # Remove published_at column
    remove_column :articles, :published_at
    
    # Update other columns
    change_column :articles, :title, :string, null: false
    change_column :articles, :body, :text, null: false
    change_column :articles, :preview, :text, null: false
    change_column :articles, :slug, :string, null: false
    change_column :articles, :keywords, :string, null: false
    change_column :articles, :description, :string, null: false
    change_column :articles, :created_at, :datetime, null: false
    change_column :articles, :updated_at, :datetime, null: false
  end
end
