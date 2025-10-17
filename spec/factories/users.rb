FactoryBot.define do
  factory :user do
    role { :general }

    trait :admin do
      role { :admin }
    end

    trait :general do
      role { :general }
    end
  end
end
