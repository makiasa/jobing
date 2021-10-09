class User < ApplicationRecord
  validates :id, presence: true

  has_secure_password
  
  belongs_to :department
  has_many :works
end
