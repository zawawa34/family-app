FactoryBot.define do
  factory :database_authentication, class: 'User::DatabaseAuthentication' do
    association :user
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
