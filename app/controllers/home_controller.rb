class HomeController < ApplicationController
  def index
    cards = current_deck ? current_deck.cards : current_user.cards

    if cards.present?
      unless @card = cards.for_review.first
        flash.now[:reviewed] = "Все карточки повторены"
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

