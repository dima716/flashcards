FactoryGirl.define do
  factory :deck do
    name "MyString"
    association :user
  end
end
