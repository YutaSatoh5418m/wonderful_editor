FactoryBot.define do
  factory :article do
    title { 'テスト記事' }
    body { 'テスト本文' }
    association :user
  end
end
