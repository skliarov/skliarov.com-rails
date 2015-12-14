class Screencast < ActiveRecord::Base
  default_scope { order('position ASC') }
  
  # Declaration of relationships
  has_many :lessons, dependent: :destroy
  belongs_to :chapter
  belongs_to :user
  
  # Validate relationships
  validates :chapter, presence: true
  validates :user, presence: true
  
  # Validate fields
  validates :title, presence: true, uniqueness: { scope: :chapter_id }
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true
  
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