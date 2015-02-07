class HomeController < ApplicationController
  def index
    if current_deck
      unless @card = current_deck.cards.for_review.first
        flash.now[:reviewed] = "Все карточки повторены"
      end
    elsif current_user.cards.present?
      unless @card = current_user.cards.for_review.first
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
