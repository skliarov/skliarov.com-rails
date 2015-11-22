class Screencast < ActiveRecord::Base
  has_many :lessons
  belongs_to :chapter
  belongs_to :user
end