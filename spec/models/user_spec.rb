require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '有効な属性値で有効であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'emailが必須であること' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'emailの一意性' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
    end
  end
end
