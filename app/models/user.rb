class User < ApplicationRecord
  has_secure_password
  
  validates :name, presence: true

  belongs_to :department, optional: true
  has_many :works
  has_many :todos
end
