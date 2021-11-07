class Todo < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  #statusの数字を文字列に変換するためのメソッドを以下に定義する。
  def datechange
    return self.deadline.strftime("%Y年%m月%d日")
  end
  
  def statuschange
    if self.status == 0
      return "未着手"
    elsif self.status == 1
      return "対応中"
    else 
      return "完了"
    end
  end
end