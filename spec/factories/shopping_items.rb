FactoryBot.define do
  factory :shopping_item do
    shopping_list { nil }
    name { "MyString" }
    quantity { "MyString" }
    memo { "MyText" }
    store_name { "MyString" }
    picked_at { "2025-10-24 00:46:12" }
    position { 1 }
  end
end
