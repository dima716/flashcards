class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    if current_user
      @cards = current_user.cards
      if @cards.empty?
        flash[:empty] = "Для начала упражнений необходимо добавить карточки"
        redirect_to new_card_path
      elsif @card = @cards.for_review.first
      else
        flash.now[:reviewed] = "Все карточки повторены"
      end
    end
  end
end
