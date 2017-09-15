class User < ActiveRecord::Base

  validates_presence_of :username, :email
  has_secure_password
  validates :username, :email, uniqueness: true
  has_many :ratings
  has_many :games, through: :ratings

end
