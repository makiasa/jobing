class Department < ApplicationRecord
  belongs_to :year
  has_many :users
  has_many :works
end
