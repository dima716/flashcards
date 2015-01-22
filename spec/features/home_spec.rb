require 'rails_helper'

describe "navigation is availabe", :type => :feature do

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

describe "checking translation", :type => :feature do
  before :each do
    create(:card)
    create(:card, original_text: "Hello", translated_text: "Привет")
    visit root_url
  end

  context "get notification" do
    it "when translation is incorrect" do
      fill_in "user_text", with: "Неправильный текст"
      click_button("Проверить")
      expect(page).to have_selector ".alert-danger"
      expect(page).to have_selector ".cards-item"
    end

    it "when translation is correct" do
      correct_text =  Card.find(page.find("#id").value).translated_text
      fill_in "user_text", with: correct_text
      click_button("Проверить")
      expect(page).to have_selector ".alert-success"
      expect(page).to have_selector ".cards-item"
    end
  end
end

describe "if all cards have been reviewed" do
  before :each do
    create(:card_reviewed)
    create(:card_reviewed, original_text: "Hello", translated_text: "Привет")
  end

  it do
    visit root_url
    expect(page).to have_content "Все карты повторены!"
  end
end
