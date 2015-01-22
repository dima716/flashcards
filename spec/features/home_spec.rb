require 'rails_helper'

describe "Main page" do
  context "navigation is available" do
    before :each do
      create(:card)
      visit root_url
    end

    it "to the main page" do
      within(".navbar-header") do
        click_link "Флэшкарточкер"
        expect(current_path).to eq(root_path)
      end
    end

    it "to the all cards page" do
      within(".navbar-nav") do
        click_link "Все карточки"
        expect(current_path).to eq(cards_path)
      end
    end

    it "to the add card page" do
      within(".navbar-nav") do
        click_link "Добавить карточку"
        expect(current_path).to eq(new_card_path)
      end
    end
  end

  context "when checking translation" do
    before :each do
      create(:card)
      visit root_url
    end

    it "should show failure message" do
      fill_in "user_text", with: "кот"
      click_button("Проверить")
      expect(page).to have_content "Неправильно"
    end

    it "should show success message" do
      fill_in "user_text", with: "собака"
      click_button("Проверить")
      expect(page).to have_content "Правильно"
    end
  end

  context "when all cards have been reviewed" do
    it "should show notification message" do
      create(:card_reviewed)
      visit root_url
      expect(page).to have_content "Все карты повторены!"
    end
  end
end
