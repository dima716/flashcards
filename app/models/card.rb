class Card < ActiveRecord::Base
  before_create :set_review_date

  belongs_to :user
  belongs_to :deck

  has_attached_file :picture, styles: { medium: "360x360#" }
  validates_attachment_content_type :picture, content_type: /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]

  validates :user, :original_text, :translated_text, presence: true
  validates_with TextsEqualityValidator

  scope :for_review, -> { where("review_date <= ?", Time.current).order("RANDOM()") }

  def check_translation(user_text)
    Util.compare_strings(user_text, translated_text)
  end

  def set_review_date
    self.review_date = Time.current
  end

  def review(user_text)
    typos_number = check_translation(user_text)

    if typos_number < 3
      update_successful_checks_counter
      update_review_date
    else
      update_unsuccessful_checks_counter
    end

    return typos_number
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
    else
      if successful_checks_counter >= 5
        update_attribute(:review_date, Time.current + 1.month)
      end
    end
  end

  def update_successful_checks_counter
    update_attributes(successful_checks_counter: successful_checks_counter + 1,
                      unsuccessful_checks_counter: 0)
  end

  def update_unsuccessful_checks_counter
    return false if successful_checks_counter == 0

    update_attribute(:unsuccessful_checks_counter, unsuccessful_checks_counter + 1)

    if unsuccessful_checks_counter == 3
      update_attributes(unsuccessful_checks_counter: 0, successful_checks_counter: 0)
    end
  end
end
