FactoryBot.define do
  factory :article_like do
    association :user
    association :article
  end
end
