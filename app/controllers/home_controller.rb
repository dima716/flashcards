class HomeController < ApplicationController
  def index
    if current_deck = current_user.current_deck
      @cards = current_deck.cards
      flash[:reviewed] = "Все карточки повторены" unless @card = @cards.for_review.first
    elsif current_user.cards.present?
      @cards = current_user.cards
      flash[:reviewed] = "Все карточки повторены" unless @card = @cards.for_review.first
    else
      flash[:empty] = "Для начала упражнений необходимо добавить карточки"
      redirect_to decks_path
    end
  end

  def not_authenticated
    render "index"
  end
end
