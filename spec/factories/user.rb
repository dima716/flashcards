FactoryGirl.define do
  factory :user do
    email "MyString"
    password "MyString"
    password_confirmation "MyString"
    profile_image_url "MyString"
    current_deck_id nil
  end
end
