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
end