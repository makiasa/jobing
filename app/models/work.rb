class Work < ApplicationRecord
  belongs_to :department
  belongs_to :user, optional: true
  has_many :todos
  has_many :workflows
end
