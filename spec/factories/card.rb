FactoryGirl.define do
  factory :card do
    original_text "MyString"
    translated_text "MyString"
    successful_checks_counter 0
    unsuccessful_checks_counter 0
    association :user
    association :deck
  end
end
