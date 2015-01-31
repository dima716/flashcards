class HomeController < ApplicationController
  def index
    current_deck = current_user.decks.current_deck.first
    @cards = current_deck ? current_deck.cards : current_user.cards

    if @cards.empty?
      flash[:empty] = "Для начала упражнений необходимо добавить карточки"
      redirect_to new_card_path
    elsif @cards.for_review.present?
      @card = @cards.for_review.first
    else
      flash.now[:reviewed] = "Все карточки повторены"
    end
  end

  def not_authenticated
    render "index"
  end
end
