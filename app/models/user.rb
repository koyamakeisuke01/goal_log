class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by(email: 'goal@goal.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  has_many :tweets
  has_many :comments
  has_many :tasks
  has_one_attached :avatar

  validates :name, presence: true, length: { maximum: 8 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
              uniqueness: true,
              format: { with: VALID_EMAIL_REGEX }

  VALID_PASSWORD_REGEX = /(?=.*\d+.*)(?=.*[a-zA-Z]+.*)./
  validates :password,
              format: { with: VALID_PASSWORD_REGEX,
                        message: "は英字と数字の両方を含めて設定してください" }
end
