class Todo < ApplicationRecord
  belongs_to :work
  belongs_to :user
  
  #statusの数字を文字列に変換するためのメソッドを以下に定義する。
  # def
  # end
end
