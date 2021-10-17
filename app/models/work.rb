class Work < ApplicationRecord
  belongs_to :department
  belongs_to :user
  has_many :todos
end
