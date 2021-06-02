require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト', limit: '2021-05-05', status_name: "未着手")
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト 其の二', content: '', limit: '2021-05-05', status_name: "未着手")
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: 'テスト成功', content: '成功テスト', limit: '2021-05-05', status_name: "未着手")
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task', limit: '2021-06-03', status_name: "未着手") }
    let!(:second_task) { FactoryBot.create(:task, title: "sample", limit: '2021-06-03', status_name: "完了") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('task')).to include(task)
        expect(Task.search_title('task')).not_to include(second_task)
        expect(Task.search_title('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('未着手')).to include(task)
        expect(Task.search_status('未着手')).not_to include(second_task)
        expect(Task.search_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('sample')).to include(second_task)
        expect(Task.search_status('完了')).to include(second_task)
        expect(Task.search_title('sample')).not_to include(task)
        expect(Task.search_status('完了')).not_to include(task)
        expect(Task.search_title('sample').count).to eq 1
        expect(Task.search_status('完了').count).to eq 1
      end
    end
  end
end
