# == Schema Information
#
# Table name: article_likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint
#  user_id    :bigint
#
class ArticleLike < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :article_id, uniqueness: { scope: :user_id }
end
