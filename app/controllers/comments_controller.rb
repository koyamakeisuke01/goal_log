class CommentsController < ApplicationController

  def index
    
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

end
