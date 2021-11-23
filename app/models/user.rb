class User < ApplicationRecord
  has_secure_password
  
  validates :name, presence: true
  validates :number, uniqueness: true

  belongs_to :department, optional: true
  has_many :works
  has_many :todos
  
  POSITION_LIST = {0 =>"課長", 1 =>"係長", 2 =>"係員"}
  
  def position_change
    POSITION_LIST[self.position]
  end
  
end
