class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :article_likes, dependent: :destroy
  has_many :liking_users, through: :article_likes, source: :user

  validates :title, presence: true
  validates :body, presence: true
end
