require 'rails_helper'

describe Card do
  subject :card { Card.new(original_text: "Goodbye", translated_text: "Пока", review_date: Date.today) }
  let :card_phrase { Card.new(original_text: "Good morning", translated_text: "Доброе утро", review_date: Date.today) }

  it { is_expected.to respond_to(:check_translation).with(1).argument }
  it { is_expected.not_to respond_to(:check_translation).with(0).arguments }

  context "#check_translation" do
    context "expect return true when user wrote" do
      it "a lowercase right word" do
        user_input = "пока"
        expect(card.check_translation(user_input)).to be == true
      end

      it "a capitalized right word" do
        user_input = "Пока"
        expect(card.check_translation(user_input)).to be == true
      end

      it "a right word with a space" do
        user_input = "Пока "
        expect(card.check_translation(user_input)).to be == true
      end

      it "a right phrase" do
        user_input = "Доброе     утро"
        expect(card_phrase.check_translation(user_input)).to be == true
      end
    end

    context "expect return false when user wrote" do
      it "a wrong word" do
        user_input = "привет"
        expect(card.check_translation(user_input)).to be == false
      end
    end
  end
end
