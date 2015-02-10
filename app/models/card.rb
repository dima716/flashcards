class Card < ActiveRecord::Base
  before_create :set_review_date

  belongs_to :user
  belongs_to :deck

  has_attached_file :picture, styles: { medium: "360x360#" }
  validates_attachment_content_type :picture, content_type: /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]

  validates :user, :original_text, :translated_text, presence: true
  validates_with TextsEqualityValidator

  scope :for_review, -> { where("score < 4 or review_date <= ?", Time.current).order("RANDOM()") }

  def check_translation(user_text)
    Util.compare_strings(user_text, translated_text)
  end

  def set_review_date
    self.review_date = Time.current
  end
end
