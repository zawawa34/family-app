FactoryBot.define do
  factory :invitation, class: 'User::Invitation' do
    association :create_user, factory: :user
    sequence(:token) { |n| SecureRandom.urlsafe_base64(32) }
    expires_at { 7.days.from_now }
    status { :unused }

    trait :unused do
      status { :unused }
    end

    trait :used do
      status { :used }
    end

    trait :expired do
      expires_at { 1.day.ago }
    end
  end
end
