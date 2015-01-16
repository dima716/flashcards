class TextsEqualityValidator < ActiveModel::Validator
  def validate(record)
    original_text = record.original_text.mb_chars.downcase.to_s.strip.squeeze(" ")
    translated_text = record.translated_text.mb_chars.downcase.to_s.strip.squeeze(" ")

    if original_text == translated_text
      record.errors[:base] << "Слова не должны совпдать"
    end
  end
end
