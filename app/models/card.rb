class Card < ActiveRecord::Base
  before_create :set_review_date

  belongs_to :user
  belongs_to :deck

  has_attached_file :picture, styles: { medium: "360x360#" }
  validates_attachment_content_type :picture, content_type: /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]

  validates :user, :original_text, :translated_text, presence: true
  validates_with TextsEqualityValidator

  scope :for_review, -> { where("review_date <= ? AND retired = ?", Time.current, false).order("RANDOM()") }

  def check_translation(user_text)
    Util.compare_strings(user_text, translated_text)
  end

  def set_review_date
    self.review_date = Time.current
  end

  def update_review_date
    case successful_checks_counter
    when 1
      update_attribute(:review_date, Time.current + 12.hours)
    when 2
      update_attribute(:review_date, Time.current + 3.days)
    when 3
      update_attribute(:review_date, Time.current + 1.week)
    when 4
      update_attribute(:review_date, Time.current + 2.weeks)
    when 5
      update_attribute(:review_date, Time.current + 1.month)
    when 6
      update_attribute(:retired, true)
    end
  end
end
