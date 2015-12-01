class Screencast < ActiveRecord::Base
  validates_presence_of :title, :body
  
  has_many :lessons
  belongs_to :chapter
  belongs_to :user
end