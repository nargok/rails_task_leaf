require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }

    before do
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
      visit login_path
      # メールアドレスを入力する
      fill_in 'メールアドレス', with: login_user.email
      # パスワードを入力する
      fill_in 'パスワード', with: login_user.password
      # ログインするボタンを押す
      click_button 'ログインする'
    end

    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済のタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content '最初のタスク'
      end
    end

    context 'ユーザBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        # ユーザAが作成したタスクをの名称が画面上に表示されていないことを確認
        expect(page).not_to have_content '最初のタスク'
      end
    end
  end

end
