class User < ApplicationRecord
  has_secure_password
  
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :number, presence: true, uniqueness: true
  validates :email, length: { maximum: 300 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, allow_blank: true

  belongs_to :department, optional: true
  has_many :works
  has_many :todos
  
  POSITION_LIST = {0 =>"市長", 1 =>"副市長", 2 =>"部長", 3 =>"部次長", 4 =>"課室長", 5 =>"係長", 6 =>"係員"}
  
  def position_change
    POSITION_LIST[self.position]
  end
  
  def full_name
    self.lastname + "　" + self.firstname
  end
  
  def self.search(keyword) #職員情報の検索機能
  where(["furigana_lastname like? OR furigana_firstname like? OR lastname like? OR firstname like?",
        "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end
  
end
