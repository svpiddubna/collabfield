FactoryBot.define do
  factory :post do
    title { "How to read a book effectively" }
    content { "There are five steps involved." }
    user
    category
  end
end
