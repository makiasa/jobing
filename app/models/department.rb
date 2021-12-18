class Department < ApplicationRecord
  has_ancestry
  
  has_many :users
  has_many :works
  
  validates :name, presence: true, uniqueness: true
  validates :number, uniqueness: true
  # validates :number, presence: true, uniqueness: true

=begin  ※以下、herokuのみでエラーのためコメントアウト
  def startdate_time(startdate)
<<<<<<< HEAD
    if startdate
      startdate.strftime("%Y年%m月%d日")
    end
  end
  
  def enddate_time(enddate)
    if enddate
      enddate.strftime("%Y年%m月%d日")
    end
=======
    startdate&.strftime("%Y年%m月%d日")
  end
  
  def enddate_time(enddate)
    enddate&.strftime("%Y年%m月%d日")
>>>>>>> ab348cab8a4ed2eb40b047d86be18909b64daf13
  end
=end
  
end
