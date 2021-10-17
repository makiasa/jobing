class User < ApplicationRecord

  has_secure_password
  
  belongs_to :department
  has_many :works
  has_many :todos
end
