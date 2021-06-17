require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user)}
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト', user: user)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task, title: 'task', user: user) }
    let!(:task2) { FactoryBot.create(:task2, title: "sample", user: user) }
    let!(:task3) { FactoryBot.create(:task3, title: 'task3', limit: '2000-02-03', created_at: '2000-01-03', status_name: '完了', user: user)}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.search_title('task').count).to eq 2
        expect(Task.search_title('task').count).not_to eq 3
        expect(Task.search_title('sample').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status(1)).not_to eq 3
        expect(Task.search_status(2).count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('task3')).to include(task3)
        expect(Task.search_status('完了')).to include(task3)
        expect(Task.search_title('task3')).not_to include(task2)
        expect(Task.search_title('task3').count).to eq 1
      end
    end
  end
end
