FactoryBot.define do
  factory :shopping_item do
    shopping_list
    sequence(:name) { |n| "商品#{n}" }
    quantity { nil }
    memo { nil }
    store_name { nil }
    picked_at { nil }
    sequence(:position)

    # カート内商品
    trait :picked do
      picked_at { Time.current }
    end

    # 未カート商品（デフォルト）
    trait :unpicked do
      picked_at { nil }
    end

    # 店舗指定あり
    trait :with_store do
      store_name { "スーパー" }
    end

    # 詳細情報あり
    trait :with_details do
      quantity { "2個" }
      memo { "セール品" }
      store_name { "スーパー" }
    end
  end
end
