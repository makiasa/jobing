class Todo < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  #statusの数字を文字列に変換するためのメソッドを以下に定義する。
  def datechange
    self.deadline.strftime("%Y年%m月%d日")
  end
  
  def statuschange(status)
    ["未着手", "対応中", "完了"][status]   #【statusについて】→　0:未着手、1:対応中、2:完了
  end
end