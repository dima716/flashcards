FactoryGirl.define do
  factory :card do
    original_text "dog"
    translated_text "собака"
    review_date Date.today

    factory :card_reviewed do
      review_date Date.today + 1
    end
  end
end
