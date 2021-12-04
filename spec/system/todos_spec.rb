require "rails_helper"

describe "Todo管理機能", type: :system do
  describe "一覧表示機能" do
    before do
      work = FactoryBot.create(:work)
      user = FactoryBot.create(:user)  # ユーザーAを作成しておく
      FactoryBot.create(:todo, user: user, work: work) # 作成者がユーザーAであるタスクを作成しておく
    end
    
    context "ユーザーAがログインしているとき" do
      before do
        visit login_path # ユーザーAでログインする
        fill_in "session[number]", with: 999
        fill_in "session[password]", with: "password"
        click_button "ログイン"
      end
      
      it "ユーザーAが作成したタスクが表示される" do
        expect(page).to have_content "テストを行う" # 作成済みのタスクの名称が画面上に表示されていることを確認
      end
    end
  end
end