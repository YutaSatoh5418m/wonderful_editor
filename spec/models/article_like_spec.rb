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
require 'rails_helper'

RSpec.describe ArticleLike, type: :model do
  describe 'バリデーション' do
    it '有効な属性値で有効であること' do
      article_like = build(:article_like)
      expect(article_like).to be_valid
    end

    it 'userが必須であること' do
      article_like = build(:article_like, user: nil)
      expect(article_like).not_to be_valid
    end

    it 'articleが必須であること' do
      article_like = build(:article_like, article: nil)
      expect(article_like).not_to be_valid
    end

    it '同じユーザーが同じ記事に複数いいねできないこと' do
      article = create(:article)
      user = create(:user)
      create(:article_like, article: article, user: user)
      article_like = build(:article_like, article: article, user: user)
      expect(article_like).not_to be_valid
    end
  end
end
