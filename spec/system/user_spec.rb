require 'rails_helper'
RSpec.describe 'ユーザー登録機能', type: :system do
  describe 'ユーザー登録テスト' do
    context 'ユーザー新規作成時' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        fill_in "user[name]", with: "test_user"
        fill_in "user[email]", with: "test@test.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_on 'Create User'
        expect(page).to have_content 'test_user'
        expect(page).to have_content 'test@test.com'
      end
    end
    context 'ログインせずにタスク一覧画面に飛んだ場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能のテスト ' do
    context 'ログインした場合' do
      it '作成したユーザーが表示される' do
        user = FactoryBot.create(:user)
        #binding.irb
        visit new_session_path
        fill_in "session[email]", with: "user1@example.com"
        fill_in "session[password]", with: "5555555"
        within '.actions' do
          click_on 'ログイン'
        end
        expect(page).to have_content 'test_user1'
        expect(page).to have_content 'user1@example.com'
      end
    end
    #binding.irb
    context '自分の詳細画面に飛んだ場合' do
      it '自分の詳細ページに遷移する' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "user1@example.com"
        fill_in "session[password]", with: "5555555"
        within '.actions' do
          click_on 'ログイン'
        end
        # binding.irb
        click_on 'タスク一覧'
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトした場合' do
      it 'ログイン画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: "user1@example.com"
        fill_in "session[password]", with: "5555555"
        within '.actions' do
          click_on 'ログイン'
        end
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_content 'ログイン'
      end
    end
  end
  describe '管理画面のテスト ' do
    context '管理ユーザーが管理画面にアクセスした場合' do
      it '管理画面に遷移する' do
        user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "user2@example.com"
        fill_in "session[password]", with: "6666666"
        within '.actions' do
          click_on 'ログイン'
        end
        click_on '管理画面'
        expect(page).to have_content '管理画面：ユーザー一覧'
      end
    end
    context '一般ユーザーが管理画面にアクセスした場合' do
      it 'タスク一覧画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: "user1@example.com"
        fill_in "session[password]", with: "5555555"
        within '.actions' do
          click_on 'ログイン'
        end
        visit admin_users_path
        expect(page).to have_content '警告！！管理画面へは管理者以外はアクセスできません。'
        expect(page).to have_content 'タスク一覧'
      end
    end
    context '管理ユーザーが管理画面でユーザーの新規登録をした場合' do
      it '管理画面のユーザー詳細ページに遷移する' do
        user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "user2@example.com"
        fill_in "session[password]", with: "6666666"
        within '.actions' do
          click_on 'ログイン'
        end
        visit admin_users_path
        click_on '新しくユーザーを作成する'
        fill_in "user[name]", with: "test_user"
        fill_in "user[email]", with: "test@test.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_on 'Create User'
        expect(page).to have_content 'ユーザー情報を登録しました'
        expect(page).to have_content '管理画面：ユーザー情報詳細'
      end
    end
    context '管理ユーザーが管理画面でユーザーの詳細ページに飛んだ場合' do
      it 'ユーザーの詳細ページに遷移する' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        # binding.irb
        fill_in "session[email]", with: "user2@example.com"
        fill_in "session[password]", with: "6666666"
        within '.actions' do
          click_on 'ログイン'
        end
        visit admin_users_path
        visit admin_user_path(user1.id)
        # binding.irb
        expect(page).to have_content '管理画面：ユーザー情報詳細'
        expect(page).to have_content 'user1'
      end
    end
    context '管理ユーザーが管理画面でユーザーの編集ページに飛んだ場合' do
      it 'ユーザーの編集ページで情報編集ができる' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "user2@example.com"
        fill_in "session[password]", with: "6666666"
        within '.actions' do
          click_on 'ログイン'
        end
        visit admin_users_path
        visit edit_admin_user_path(user1.id)
        fill_in "user[name]", with: "edit_user"
        fill_in "user[email]", with: "edit@edit.com"
        fill_in "user[password]", with: "password_edit"
        fill_in "user[password_confirmation]", with: "password_edit"
        click_on 'Update User'
        expect(page).to have_content 'ユーザー情報を編集しました'
        expect(page).to have_content '管理画面：ユーザー情報詳細'
        expect(page).to have_content 'edit_user'
      end
    end
    context '管理ユーザーが管理画面でユーザーの削除ボタンを押した場合' do
      it 'ユーザーの削除ができる' do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "user2@example.com"
        fill_in "session[password]", with: "6666666"
        within '.actions' do
          click_on 'ログイン'
        end
        # binding.irb
        visit admin_users_path
        #binding.irb
        within 'ul li:first-child' do
          page.accept_confirm do #確認画面のボタンを押すため
            click_on 'ユーザー情報を削除する'
          end
        end
        expect(page).to have_content 'ユーザー情報を削除しました'
      end
    end
  end
end