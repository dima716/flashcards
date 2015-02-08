class TextsEqualityValidator < ActiveModel::Validator
  def validate(record)
    if Util.compare_strings(record.original_text, record.translated_text) == 0
      record.errors[:base] << "Слова не должны совпадать"
    end
  end
end
