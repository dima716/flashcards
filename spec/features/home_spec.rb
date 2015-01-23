require 'rails_helper'

describe "Main page" do
  context "when checking translation" do
    before :each do
      user = create(:user, email: "john@example.com", password: "test")
      card = create(:card, original_text: "Test", translated_text: "Тест", user: user)
      visit root_url
    end

    it "should show failure message" do
      fill_in "user_text", with: "Нетест"
      click_button("Проверить")
      expect(page).to have_content "Неправильно"
    end

    it "should show success message" do
      fill_in "user_text", with: "Тест"
      click_button("Проверить")
      expect(page).to have_content "Правильно"
    end
  end

  context "when all cards have been reviewed" do
    it "should show notification message" do
      user = create(:user, email: "john@example.com", password: "test")
      create(:card_reviewed, original_text: "Test", translated_text: "Тест", user: user)
      visit root_url
      expect(page).to have_content "Все карты повторены!"
    end
  end
end
