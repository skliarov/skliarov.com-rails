class User < ActiveRecord::Base
  # Declaration of relationships
  has_many :articles, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  def username
    return 'username'
  end
end