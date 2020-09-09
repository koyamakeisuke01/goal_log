class TweetsController < ApplicationController
  before_action :login_check, only: :new
  def index
    @tweets = Tweet.includes(:user).order("updated_at DESC")
    @tweet = Tweet.new
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.valid?
      @tweet.save
      redirect_to root_path
    else
      @tweets = Tweet.includes(:user).order("updated_at DESC")
      render :index
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to user_path(current_user), notice:  "投稿を削除しました。"
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user).order(created_at: :desc)
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
