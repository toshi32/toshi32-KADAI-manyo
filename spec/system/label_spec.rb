require 'rails_helper'
RSpec.describe 'ラベル登録機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task2) { FactoryBot.create(:task2, user_id: user.id) }
  # let!(:label) { FactoryBot.create(:label) }
  # let!(:label2) { FactoryBot.create(:label2) }
  # let!(:label3) { FactoryBot.create(:label3) }
  before do
    visit new_session_path
    fill_in "session[email]", with: "user1@example.com"
    fill_in "session[password]", with: "5555555"
    within '.actions' do
      click_on 'ログイン'
    end
    visit tasks_path
  end
  describe 'ラベル登録のテスト' do
    context 'タスク作成時にラベルを選択した場合' do
      it 'タスクにラベルが紐づいて表示される' do
        FactoryBot.create(:label)
        # FactoryBot.create(:label2)
        # FactoryBot.create(:label3)
        visit new_task_path
        #binding.irb
        #sleep(0.5)
        fill_in 'task[title]', with: "タースークー"
        fill_in "task[content]", with: "なーいーよー"
        find("#task_limit_1i").find("option[value='2021']").select_option
        find("#task_limit_2i").find("option[value='6']").select_option
        find("#task_limit_3i").find("option[value='3']").select_option
        find("#task_status_name").find("option[value='着手']").select_option
        find("#task_priority").find("option[value='高']").select_option
        check "NEW BOOK"
        page.accept_confirm do
          click_on '登録する'
        end
        expect(page).to have_content 'タースークー'
        expect(page).to have_content "NEW BOOK"
      end
    end
    context 'タスク編集時にラベルを別のものにした場合' do
      it '変更したタスクにラベルが紐づいて表示される' do
        FactoryBot.create(:label2)
        FactoryBot.create(:label3)
        #binding.irb
        visit edit_task_path(task2.id)
        #binding.irb
        check 'FNL CHK'
        uncheck 'NET CHK'
        page.accept_confirm do
          click_on '登録する'
        end
        expect(page).to have_content 'task2'
        expect(page).to have_content 'FNL CHK'
      end
    end
  end
  describe 'ラベル検索のテスト' do
    context 'ラベル名で検索した場合' do
      it '選択したラベルのついたタスクが表示される' do
        FactoryBot.create(:label)
        FactoryBot.create(:label2)
        FactoryBot.create(:label3)
        visit new_task_path
        fill_in "task[title]", with: "task_name1"
        fill_in "task[content]", with: "task_content1"
        find("#task_limit_1i").find("option[value='2021']").select_option
        find("#task_limit_2i").find("option[value='5']").select_option
        find("#task_limit_3i").find("option[value='3']").select_option
        find("#task_status_name").find("option[value='着手']").select_option
        check 'NEW BOOK'
        page.accept_confirm do
          click_on '登録する'
        end
        visit new_task_path
        fill_in "task[title]", with: "task_name2"
        fill_in "task[content]", with: "task_content2"
        find("#task_limit_1i").find("option[value='2021']").select_option
        find("#task_limit_2i").find("option[value='6']").select_option
        find("#task_limit_3i").find("option[value='3']").select_option
        find("#task_status_name").find("option[value='完了']").select_option
        check 'NET CHK'
        page.accept_confirm do
          click_on '登録する'
        end
        select "NEW BOOK", from: "search_label"
        within '.search_box' do
          click_on '検索'
        end
        expect(page).to have_content 'task_name1'
        expect(page).to have_content 'NEW BOOK'
      end
    end
  end
end