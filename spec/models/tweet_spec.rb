require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe 'ツイートの保存' do
    context "ツイートが保存できる場合" do
      it "画像とテキストがあればツイートは保存される" do
        expect(@tweet).to be_valid
      end

      it "テキストのみであればツイートは保存される" do
        @tweet.image = nil
        expect(@tweet).to be_valid
      end

      it 'imageが存在していれば保存できること' do
        @tweet.text = ""
        expect(@tweet).to be_valid
      end
    end

    context "ツイートが保存できない場合" do
      it "テキストと画像が空の場合、ツイートは保存できない" do
        @tweet.text = ""
        @tweet.image = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("テキストを入力してください")
      end

      it "ユーザーが紐付いていないとツイートは保存できない" do
        @tweet.user = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
