class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: { message: "%{value} не может быть пустым" }
  validates_with TextsEqualityValidator

  scope :review, -> { where("review_date <= ?", Date.today) }

  def equale(user_text)
    user_text = user_text.mb_chars.downcase.to_s.strip.squeeze(" ")
    translated_text = self.translated_text.mb_chars.downcase.to_s.strip.squeeze(" ")

    if user_text != translated_text
      return false
    end

    self.review_date += 3
    self.save
  end
end
