class TweetsController < ApplicationController
  before_action :login_check, only: :new
  def index
    
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    # 必須項目を正常に入力している場合、DBに保存しトップページへ遷移
    if @tweet.valid?
      @tweet.save
      redirect_to root_path
    # 未記入の項目がある場合、エラーメッセージを表示
    else
      render :new
    end
  end

  private
  def login_check
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def tweet_params
    params.require(:tweet).permit(:text, :image).merge(user_id: current_user.id)
  end
end
