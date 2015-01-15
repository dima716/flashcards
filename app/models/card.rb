class GoodnessValidator < ActiveModel::Validator
  def validate(record)
    if record.original_text? &&
      record.translated_text? &&
      record.original_text.downcase.strip.split(' ') == record.translated_text.downcase.strip.split(' ')
      record.errors[:base] << "Слова не должны совпдать"
    end
  end
end

class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: {
    in: true,
    message: "%{value} не может быть пустым"
  }

  validates_with GoodnessValidator
end
