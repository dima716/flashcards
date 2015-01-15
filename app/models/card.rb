class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: { message: "%{value} не может быть пустым" }
  validates_with TextsEqualityValidator
end
