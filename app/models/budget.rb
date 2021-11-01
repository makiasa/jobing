class Budget < ApplicationRecord
  belongs_to :department
  has_many :works
end
