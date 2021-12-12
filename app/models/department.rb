class Department < ApplicationRecord
  has_ancestry
  
  has_many :users
  has_many :works
  
  # validates :number, presence: true, uniqueness: true
  
  DEPARTMENT_LIST =  {1 =>"環境衛生課", 2 =>"衛生環境課"}
  
end
