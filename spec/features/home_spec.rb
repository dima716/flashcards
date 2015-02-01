require 'rails_helper'

describe "Main page" do
  context "when checking translation" do
    before :each do
      user = create(:user, email: "john@example.com", password: "test", password_confirmation: "test")
      deck = create(:deck, name: "Testdeck", user: user)
      create(:card, original_text: "Test", translated_text: "Тест", user: user, deck: deck)
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
      deck = create(:deck, name: "Testdeck", user: user)
      create(:card_reviewed, original_text: "Test", translated_text: "Тест", user: user, deck: deck)
      login_user_post(user.email, "test")
      visit root_url
      expect(page).to have_content "Все карточки повторены"
    end
  end

  context "when there aren't any cards in database" do
    it "should show decks index page" do
      user = create(:user, email: "john@example.com", password: "test", password_confirmation: "test")
      login_user_post(user.email, "test")
      visit root_url
      expect(page).to have_content "Добавить колоду"
    end
  end

  context "when user trying to open another user's deck to see cards" do
    it "should redirect to main page" do
      user_one = create(:user, email: "john@example.com", password: "john", password_confirmation: "john")
      user_two = create(:user, email: "mike@example.com", password: "mike", password_confirmation: "mike")
      deck_one = create(:deck, name: "Johndeck", user: user_one)
      deck_two = create(:deck, name: "Mikedeck", user: user_two)
      create(:card, original_text: "Test", translated_text: "Тест", user: user_one, deck: deck_one)
      create(:card, original_text: "Test", translated_text: "Тест", user: user_two, deck: deck_two)
      login_user_post(user_one.email, "john")
      visit deck_cards_path(deck_two)
      expect(current_path).to eq(root_path)
    end
  end

  context "when there is a current deck" do
    it "should show card from the current deck" do
      user = create(:user, email: "john@example.com", password: "john", password_confirmation: "john")
      deck_one = create(:deck, name: "Currentdeck", user: user)
      deck_two = create(:deck, name: "Deck", user: user)
      create(:card, original_text: "Test current", translated_text: "Тест текущий", user: user, deck: deck_one)
      create(:card, original_text: "Test", translated_text: "Тест", user: user, deck: deck_two)
      user.current_deck = deck_one
      login_user_post(user.email, "john")
      visit root_url
      expect(page).to have_content("Test current")
    end
  end
end
