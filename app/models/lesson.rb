class Lesson < ActiveRecord::Base
  belongs_to :screencast
  belongs_to :user
end