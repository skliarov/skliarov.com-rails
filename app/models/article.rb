class Article < ActiveRecord::Base
  # Add ability to upload preview images
  mount_uploader :preview_image, PreviewImageUploader
  
  # Declaration of relationships
  belongs_to :user
  
  # Validate relationships
  validates :user, presence: true
  
  # Validate fields
  validates :title, presence: true, uniqueness: true
  validates :preview, presence: true
  validates :body, presence: true
  validates :keywords, presence: true
  validates :description, presence: true
  validates :slug, presence: true, uniqueness: true
  
  # Add user-friendly URL slug
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  def slug_candidates
    [[:id, :title]]
  end
  
  # Set position to be the last in the list
  before_create :set_default_position
  
  private
    def set_default_position
      self.position = 1
      if Article.count > 0
        self.position = Article.maximum('position') + 1
      end
    end
end