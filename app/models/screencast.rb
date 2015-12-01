class Screencast < ActiveRecord::Base
  # Validate fields
  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :body, presence: true
  
  # Validate relationships
  validates :chapter, presence: true
  validates :user, presence: true
  
  # Declaration of relationships
  has_many :lessons
  belongs_to :chapter
  belongs_to :user
  
  # Add user-friendly URL slug
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  def slug_candidates
    [
      [:slug],
      [:title],
      [:id, :title]
    ]
  end
end