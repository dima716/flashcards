class TextsEqualityValidator < ActiveModel::Validator
  def validate(record)
    if Util.compare_strings(record.original_text, record.translated_text)
      record.errors[:base] << "Слова не должны совпдать"
    end
  end
end
