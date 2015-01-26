FactoryGirl.define do
  factory :user do
    email "MyString"
    password "MyString"
    password_confirmation "MyString"
    salt "asdasdastr4325234324sdfds"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("secret", "asdasdastr4325234324sdfds")
    profile_image_url "MyString"
  end
end
