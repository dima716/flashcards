require 'rails_helper'
require 'super_memo_2'

describe SuperMemo2 do
  let(:user) { create(:user, email: "john@example.com", password: "test", password_confirmation: "test") }
  let(:deck) { create(:deck, name: "Testdeck", user: user) }
  let(:card) { create(:card, original_text: "Goodbye", translated_text: "Пока", user: user, deck: deck) }

  context "#review" do
    it "should return a hash with new review attributes when score is more than 2" do
      Timecop.freeze(Time.current) do
        attributes = SuperMemo2.new(score: 3,
                                    repetition_number: card.repetition_number,
                                    repetition_interval: card.repetition_interval,
                                    ef: card.ef).review

        expect(attributes).to eq ({ score: 3,
                                    repetition_number: 1,
                                    repetition_interval: 1,
                                    ef: 2.36,
                                    review_date: Time.current + 1.day })
      end
    end

    it "should return a hash with repetition_number and score when score is less or equal 2" do
      attributes = SuperMemo2.new(score: 2,
                                  repetition_number: card.repetition_number,
                                  repetition_interval: card.repetition_interval,
                                  ef: card.ef).review
      expect(attributes).to eq ({ score: 2, repetition_number: 0 })
    end
  end
end
