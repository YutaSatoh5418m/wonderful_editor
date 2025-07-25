# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint
#  user_id    :bigint
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :body, presence: true
end
