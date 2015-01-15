class TextsEqualValidator < ActiveModel::Validator
  def validate(record)
    if record.original_text? &&
      record.translated_text? &&
      record.original_text.downcase.strip.split(' ') == record.translated_text.downcase.strip.split(' ')
      record.errors[:base] << "Слова не должны совпдать"
    end
  end
end
