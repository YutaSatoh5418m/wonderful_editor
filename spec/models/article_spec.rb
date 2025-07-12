# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'バリデーション' do
    it '有効な属性値で有効であること' do
      article = build(:article)
      expect(article).to be_valid
    end

    it 'titleが必須であること' do
      article = build(:article, title: nil)
      expect(article).not_to be_valid
    end

    it 'bodyが必須であること' do
      article = build(:article, body: nil)
      expect(article).not_to be_valid
    end
  end
end
