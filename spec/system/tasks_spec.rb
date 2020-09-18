require 'rails_helper'

RSpec.describe 'タスク投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task_title = Faker::Lorem.sentence
  end
  context 'タスク投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # タスク投稿ページへのリンクがあることを確認する
      expect(page).to have_content('タスク管理')
      # 投稿ページに移動する
      visit todo_task_path(:id)
      # フォームに情報を入力する
      fill_in 'task_title', with: @task_title
      # 送信するとTaskモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Task.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq todo_task_path(:id)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@task_title)
    end
  end
end
