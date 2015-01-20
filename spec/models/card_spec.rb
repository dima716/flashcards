require 'rails_helper'

describe Card do
  subject(:card) { Card.new(original_text:"Goodbye", translated_text: "Пока", review_date: Date.today) }

  it { is_expected.to respond_to(:check_translation).with(1).argument }
  it { is_expected.not_to respond_to(:check_translation).with(0).arguments }

  context "#check_translation" do
    it "expect return false" do
       user_input = "Привет"
       expect(card.check_translation(user_input)).to be == false
    end

    it "expect return true" do
      user_input = "Пока"
      expect(card.check_translation(user_input)).to be == true
    end
  end
end
