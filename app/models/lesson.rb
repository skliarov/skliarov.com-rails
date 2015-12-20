class Lesson < ActiveRecord::Base
  default_scope { order('position ASC') }
  
  # Add ability to upload preview images
  mount_uploader :preview_image, PreviewImageUploader
  
  # Declaration of relationships
  belongs_to :screencast
  belongs_to :user
  
  # Validate relationships
  validates :screencast, presence: true
  validates :user, presence: true
  
  # Validate fields
  validates :title, presence: true, uniqueness: { scope: :screencast_id }
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/, message: 'Only lower case letters, numbers and dashes are allowed' }
  
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