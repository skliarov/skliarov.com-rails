class Article < ActiveRecord::Base
	validates_presence_of :title, :preview, :body, :keywords, :description
	belongs_to :user
  
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  def slug_candidates
    [[:id, :title]]
  end
end