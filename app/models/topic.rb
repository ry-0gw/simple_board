class Topic < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
end
