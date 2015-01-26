require 'rails_helper'

describe "Main page" do
  context "when checking translation" do
    before :each do
      user = create(:user, email: "john@example.com", password: "test", password_confirmation: "test")
      create(:card, original_text: "Test", translated_text: "Тест", user: user)
      login_user_post(user.email, "test")
      visit root_path
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
      user = create(:user, email: "john@example.com", password: "test", password_confirmation: "test")
      create(:card_reviewed, original_text: "Test", translated_text: "Тест", user: user)
      login_user_post(user.email, "test")
      visit root_url
      expect(page).to have_content "Все карточки повторены"
    end
  end

  context "when there are no cards in database" do
    it "should show notification message" do
      user = create(:user, email: "john@example.com", password: "test", password_confirmation: "test")
      login_user_post(user.email, "test")
      visit root_url
      expect(page).to have_content "Вы еще не добавили ни одной карточки"
    end
  end
end
