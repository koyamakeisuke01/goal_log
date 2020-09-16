require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "全ての情報が存在する場合、登録できること" do
      expect(@user).to be_valid
    end

    it "nicknameが8文字以下で登録できる" do
      @user.name = "aaaaaaaa"
      expect(@user).to be_valid
    end

    it "passwordが6文字以上の英数字であれば登録できる" do
      @user.password = "000aaa"
      @user.password_confirmation = "000aaa"
      expect(@user).to be_valid
    end

    it "ニックネームが空の場合、登録できないこと" do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end

    it "メールアドレスが空の場合、登録できないこと" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end

    it "重複したメールアドレスが存在する場合、登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
    end

    it "メールアドレスに@がない場合、登録できないこと" do
      @user.email = "test"
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールは不正な値です")
    end

    it "パスワードが空の場合、登録できないこと" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end

    it "パスワードが6文字以上でない場合、登録できないこと" do
      @user.password = "test1"
      @user.password_confirmation = "test1"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
    end

    it "パスワードが半角英数字混合でない場合、登録できないこと" do
      @user.password = "00000"
      @user.password_confirmation = "00000"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは英字と数字の両方を含めて設定してください")
    end

    it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end

  end
end
