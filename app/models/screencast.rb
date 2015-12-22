class Screencast < ActiveRecord::Base
  default_scope { order('position ASC') }
  
  # Add ability to upload preview images
  mount_uploader :preview_image, PreviewImageUploader
  
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
  
  # Set position to be the last in the list
  before_create :set_default_position
  
  private
    def set_default_position
      self.position = 1
      if self.chapter.screencasts.count > 0
        self.position = self.chapter.screencasts.maximum('position') + 1
      end
    end
end