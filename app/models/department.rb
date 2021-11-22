class Department < ApplicationRecord
  has_many :users
  has_many :works
  
  DEPARTMENT_LIST =  {1 =>"環境衛生課", 2 =>"衛生環境課"}
  
end
