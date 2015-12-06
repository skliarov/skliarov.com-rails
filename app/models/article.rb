class Article < ActiveRecord::Base
  # Declaration of relationships
  belongs_to :user
  
  # Validate fields
  validates :title, presence: true
  validates :preview, presence: true
  validates :body, presence: true
  validates :keywords, presence: true
  validates :description, presence: true
  
  # Add user-friendly URL slug
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  def slug_candidates
    [[:id, :title]]
  end
  
  # Set position to be the last in the list
  before_create :set_default_position
  
  def set_default_position
    # Default position
    self.position = 1
    # Update position if other published/not published articles are present
    articles_count = Article.where(published: self.published).count
    if articles_count > 0
      self.position = Article.where(published: self.published).maximum('position') + 1
    end
  end
end