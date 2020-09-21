class HomesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to tweets_path, notice:  "既にログインしています"
    else
      @tweets = Tweet.order(updated_at: "DESC").page(params[:page]).per(5)
    end
  end
end
