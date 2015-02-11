FactoryGirl.define do
  factory :card do
    original_text "MyString"
    translated_text "MyString"
    association :user
    association :deck
  end
end
