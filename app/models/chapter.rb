class Chapter < ActiveRecord::Base
  default_scope { order('position ASC') }
  
  # Declaration of relationships
  has_many :screencasts, dependent: :destroy
  belongs_to :user
  
  # Validate relationships
  validates :user, presence: true
  
  # Validate fields
  validates :title, presence: true, uniqueness: true
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
      if Chapter.count > 0
        self.position = Chapter.maximum('position') + 1
      end
    end
end