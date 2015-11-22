class Chapter < ActiveRecord::Base
  has_many :screencasts
  belongs_to :user
end