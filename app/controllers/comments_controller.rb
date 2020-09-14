class CommentsController < ApplicationController

  def index    
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.valid?
      @comment.update(update_comment_params)
      redirect_to "/tweets/#{@comment.tweet.id}"
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to "/tweets/#{@comment.tweet.id}", notice:  "投稿を削除しました。"
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to "/tweets/#{@comment.tweet.id}"
    else
      @tweet = Tweet.find(params[:tweet_id])
      render template: "tweets/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end

  def update_comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: @comment.tweet.id)
  end


end
