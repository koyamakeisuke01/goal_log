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

  validates :name, presence: true
end
