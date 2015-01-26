class HomeController < ApplicationController
  skip_before_filter :require_login

  def index
    if current_user
      @cards = current_user.cards

      if @cards.empty?
        flash.now[:empty] = "Вы еще не добавили ни одной карточки"
      elsif !@cards.for_review.first
        flash.now[:reviewed] = "Все карточки повторены"
      else
        @card = @cards.for_review.first
      end
    end
  end
end
