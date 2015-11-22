class User < ActiveRecord::Base
  belongs_to :role
  has_many :articles
  has_many :chapters
  has_many :screencasts
  has_many :lessons
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end