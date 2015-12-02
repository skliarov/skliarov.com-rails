class User < ActiveRecord::Base
  # Declaration of relationships
  has_many :articles
  has_many :chapters
  has_many :screencasts
  has_many :lessons
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  def username
    return 'username'
  end
end