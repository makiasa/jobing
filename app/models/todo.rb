class Todo < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  validates :deadline, presence: true
  validates :content, presence: true
  validates :status, presence: true
  
  def datechange
    self.deadline.strftime("%Y年%m月%d日")
  end
  
  STATUS_JAPANESE = ["未着手", "対応中", "完了"]  #【statusについて】→　0:未着手、1:対応中、2:完了
  
  def statuschange(status)
    STATUS_JAPANESE[status]   
  end
end