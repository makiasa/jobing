class Workflow < ApplicationRecord
  has_one_attached :file
  
  belongs_to :work
  default_scope -> { order(:number) }
end
