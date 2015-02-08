module Util
  def self.compare_strings(str1, str2)
    Levenshtein.distance(str1.mb_chars.downcase.to_s.strip.squeeze(" "),
                         str2.mb_chars.downcase.to_s.strip.squeeze(" "))
  end
end
