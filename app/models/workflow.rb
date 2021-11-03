class Workflow < ApplicationRecord
  belongs_to :work
  default_scope -> { order(:number) }
end
