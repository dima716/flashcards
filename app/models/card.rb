class Card < ActiveRecord::Base
  belongs_to :user

  has_attached_file :picture, styles: { medium: "360x360#" }
  validates_attachment_content_type :picture, content_type: /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]

  validates :user, presence: true
  validates :original_text, :translated_text, presence: true
  validates_with TextsEqualityValidator

  scope :for_review, -> { where("review_date <= ?", Date.today).order("RANDOM()") }

  def check_translation(user_text)
    return false unless Util.compare_strings(user_text, translated_text)

    update_attributes(review_date: self.review_date += 3)
  end
end
