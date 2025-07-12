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
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーション' do
    it '有効な属性値で有効であること' do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it '本文が必須であること' do
      comment = build(:comment, body: nil)
      expect(comment).not_to be_valid
    end
  end
end
