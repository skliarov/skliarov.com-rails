class Chapter < ActiveRecord::Base
  default_scope { order('position ASC') }
  
  # Declaration of relationships
  has_many :screencasts
  belongs_to :user
  
  # Validate fields
  validates :title, presence: true, uniqueness: true
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