class HomeController < ApplicationController

  def index
    @cards = current_user.cards

    if @cards.empty?
      flash[:empty] = "Для начала упражнений необходимо добавить карточки"
      redirect_to new_card_path
    elsif @cards.for_review.any?
      @card = @cards.for_review.first
    else
      flash.now[:reviewed] = "Все карточки повторены"
    end
  end

  def not_authenticated
    render "index"
  end
end
