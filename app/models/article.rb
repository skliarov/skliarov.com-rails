class Article < ActiveRecord::Base
	validates_presence_of :title, :body
	validates_uniqueness_of :title
	belongs_to :user

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [[:id, :title]]
  end
end