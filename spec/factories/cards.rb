FactoryGirl.define do
  factory :card do
    original_text "MyString"
    translated_text "MyString"
    review_date Date.today

    factory :card_reviewed do
      review_date Date.today + 1
    end
  end
end
