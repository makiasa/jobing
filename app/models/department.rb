class Department < ApplicationRecord
  has_ancestry
  
  has_many :users
  has_many :works
  
  validates :name, presence: true, uniqueness: true
  validates :number, uniqueness: true
  # validates :number, presence: true, uniqueness: true

  def startdate_time(startdate)
    if startdate
      startdate.strftime("%Y年%m月%d日")
    end
  end
  
  def enddate_time(enddate)
    if enddate
      enddate.strftime("%Y年%m月%d日")
    end
  end
  
end
