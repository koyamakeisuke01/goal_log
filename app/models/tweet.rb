class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  validates :text, presence: true, unless: :was_attached?, length: { maximum: 140 }

  def was_attached?
    self.image.attached?
  end
end
