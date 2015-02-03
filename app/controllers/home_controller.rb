class HomeController < ApplicationController
  def index
    if current_deck = current_user.current_deck
      @cards = current_deck.cards
      unless @card = @cards.for_review.first
        flash[:reviewed] = "Все карточки повторены"
        redirect_to decks_path
      end
    elsif current_user.cards.present?
      @cards = current_user.cards
      unless @card = @cards.for_review.first
        flash[:reviewed] = "Все карточки повторены"
        redirect_to decks_path
      end
    else
      flash[:empty] = "Для начала упражнений необходимо добавить карточки"
      redirect_to decks_path
    end
  end

  def not_authenticated
    render "index"
  end
end
