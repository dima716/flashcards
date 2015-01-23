class Card < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :original_text, :translated_text, presence: { message: "%{value} не может быть пустым" }
  validates_with TextsEqualityValidator

  scope :for_review, -> { where("review_date <= ?", Date.today).order("RANDOM()") }

  def check_translation(user_text)
    return false unless Util.compare_strings(user_text, translated_text)

    update_attributes(review_date: self.review_date += 3)
  end
end
