class Department < ApplicationRecord
  has_ancestry
  
  has_many :users
  has_many :works
  
  validates :name, presence: true
  # validates :number, presence: true, uniqueness: true
  
  DEPARTMENT_LIST =  {1 =>"環境衛生課", 2 =>"衛生環境課", 3 =>"市民環境部"}
  
  def startdate_time(startdate)
    startdate&.strftime("%Y年%m月%d日")
  end
  
  def enddate_time(enddate)
    enddate&.strftime("%Y年%m月%d日")
  end
  
end
