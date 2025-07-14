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
FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph(sentence_count: 1) }
    association :user
    association :article
  end
end
