class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: {
    in: true,
    message: "%{value} не может быть пустым"
  }

  validates_with TextsEqualValidator
end
