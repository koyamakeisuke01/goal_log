require 'rails_helper'

RSpec.describe 'タスク登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task_title = Faker::Lorem.sentence
  end
  context 'タスク登録ができるとき'do
    it 'ログインしたユーザーは新規登録できる' do
      # ログインする
      sign_in(@user)
      # タスク登録ページへのリンクがあることを確認する
      expect(page).to have_content('タスク管理')
      # 登録ページに移動する
      visit todo_task_path(:id)
      # フォームに情報を入力する
      fill_in 'task_title', with: @task_title
      # 送信するとTaskモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Task.count }.by(1)
      # 登録完了ページに遷移することを確認する
      expect(current_path).to eq todo_task_path(:id)
      # トップページには先ほど登録した内容のツイートが存在することを確認する
      expect(page).to have_content(@task_title)
    end
  end
  context 'タスク登録ができないとき'do
    it 'ログインしていないとタスク管理ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規登録ページへのリンクがない
      expect(page).to have_no_content('タスク管理')
    end
    it '送る値が空の為、タスクの登録に失敗すること' do
      # ログインする
      sign_in(@user)
      # 新規登録ページへのリンクがあることを確認する
      expect(page).to have_content('タスク管理')
      # 登録ページに移動する
      visit todo_task_path(:id)
      # DBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
      }.not_to change { Task.count }
      # 元のページに戻ってくることを確認する
      expect(current_path).to eq tasks_path
    end
  end
end
