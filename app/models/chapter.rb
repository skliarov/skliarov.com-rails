class Chapter < ActiveRecord::Base
  validates_presence_of :title, :slug
  validates_uniqueness_of :title, :slug
  
  has_many :screencasts
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