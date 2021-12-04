require "rails_helper"

describe "テスト", type: :system do

  let(:one){1}
  let(:two){2}
  
  it "1+1の計算ができる" do
    expect(one + two).to  eq 3 
  end
end