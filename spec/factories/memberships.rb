# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do
    paak_id 1
    user_id 1
    period_id 1
    name "MyString"
  end
end
