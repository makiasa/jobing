class Work < ApplicationRecord
  belongs_to :department , optional: true
  belongs_to :user, optional: true
  has_many :todos
  has_many :workflows, dependent: :destroy
  accepts_nested_attributes_for :workflows, reject_if: :all_blank, allow_destroy: true
  
end
