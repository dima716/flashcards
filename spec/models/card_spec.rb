require 'rails_helper'
require 'super_memo_2'

describe Card do
  let(:user) { create(:user, email: "john@example.com", password: "test", password_confirmation: "test") }
  let(:deck) { create(:deck, name: "Testdeck", user: user) }
  subject(:card) { create(:card, original_text: "Goodbye", translated_text: "Пока", user: user, deck: deck) }
  let(:card_with_phrase) { create(:card, original_text: "Good morning", translated_text: "Доброе утро", user: user, deck: deck) }

  it { is_expected.to respond_to(:check_translation).with(1).argument }
  it { is_expected.not_to respond_to(:check_translation).with(0).arguments }

  context "#set_review_date" do
    it "should set card's review date before creating card" do
      expect(card.review_date).to_not be_nil
    end
  end

  context "#check_translation" do
    context "expect return true when user wrote" do
      it "a lowercase right word" do
        correct_translation = "пока"
        expect(card.check_translation(correct_translation)).to be 0
      end

      it "a capitalized right word" do
        correct_translation = "Пока"
        expect(card.check_translation(correct_translation)).to be 0
      end

      it "a right word with a space" do
        correct_translation = "Пока "
        expect(card.check_translation(correct_translation)).to be 0
      end

      it "a right phrase" do
        correct_translation = "Доброе     утро"
        expect(card_with_phrase.check_translation(correct_translation)).to be 0
      end
    end

    context "expect return false when user wrote" do
      it "a wrong word" do
        incorrect_translation = "привет"
        expect(card.check_translation(incorrect_translation)).to be > 0
      end
    end
  end

  context "review with SuperMemo2 algorithm" do
    it "should update card's review date when score is more or equal 3" do
      old_review_date = card.review_date
      attributes = SuperMemo2.new(score: 3,
                                  repetition_number: card.repetition_number,
                                  repetition_interval: card.repetition_interval,
                                  ef: card.ef).review
      card.update(attributes)
      expect(card.review_date).to be > old_review_date
    end

    it "should reset card's repetition_number when score is less than 3" do
      attributes = SuperMemo2.new(score: 2,
                                  repetition_number: card.repetition_number,
                                  repetition_interval: card.repetition_interval,
                                  ef: card.ef).review
      card.update(attributes)
      expect(card.repetition_number).to be 0
    end
  end
end
