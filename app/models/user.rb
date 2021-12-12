class User < ApplicationRecord
  has_secure_password
  
  validates :name, presence: true
  validates :number, presence: true, uniqueness: true
  validates :email, length: { maximum: 300 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, allow_blank: true

  belongs_to :department, optional: true
  has_many :works
  has_many :todos
  
  POSITION_LIST = {0 =>"市長", 1 =>"副市長", 2 =>"部長", 3 =>"部次長", 4 =>"課室長", 5 =>"係長", 6 =>"係員"}
  
  def position_change
    POSITION_LIST[self.position]
  end
  
end
