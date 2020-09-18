require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet_text = Faker::Lorem.sentence
    @tweet_image = Rails.root.join('public/images/test_image.png')
  end
  context 'ツイート投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる（テキストと画像）' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('タイムライン')
      # 投稿ページに移動する
      visit tweets_path
      # フォームに情報を入力する
      fill_in 'tweet_text', with: @tweet_text
      attach_file('tweet_image', @tweet_image, make_visible: true)      
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq tweets_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@tweet_text)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector "img"
    end
    it 'ログインしたユーザーは新規投稿できる（テキストのみ）' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('タイムライン')
      # 投稿ページに移動する
      visit tweets_path
      # フォームに情報を入力する
      fill_in 'tweet_text', with: @tweet_text
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq tweets_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@tweet_text)
    end
    it 'ログインしたユーザーは新規投稿できる（画像のみ）' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('タイムライン')
      # 投稿ページに移動する
      visit tweets_path
      # フォームに情報を入力する
      attach_file('tweet_image', @tweet_image, make_visible: true)      
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq tweets_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector "img"
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('タイムライン')
    end
    it '送る値が空の為、メッセージの送信に失敗すること' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('タイムライン')
      # 投稿ページに移動する
      visit tweets_path
      # DBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
      }.not_to change { Tweet.count }
      # 元のページに戻ってくることを確認する
      expect(current_path).to eq tweets_path
    end
  end
end
