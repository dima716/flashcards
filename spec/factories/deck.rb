FactoryGirl.define do
  factory :deck do
    name "MyString"
    current false
    association :user
  end
end
