# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :email do |n| "user#{'%03i' % (n + 1)}@test.com" end
    password "password"
  end
end