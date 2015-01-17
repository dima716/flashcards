class CardsController < ApplicationController
  before_action :get_card, only: [:edit, :update, :destroy]

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to cards_path
    else
      render "new"
    end
  end

  def index
    @cards = Card.all
  end

  def show
    if params[:user_text]
      get_card
      user_text = params[:user_text].mb_chars.downcase.to_s.strip.squeeze(" ")
      translated_text = @card.translated_text.mb_chars.downcase.to_s.strip.squeeze(" ")

      if user_text == translated_text
        flash.now[:notice] = "Правильно"
        @card.review_date += 3
        @card.save
      else
        flash.now[:notice] = "Неправильно"
      end
    end

    get_random_card
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def get_card
    @card = Card.find(params[:id])
  end

  def get_random_card
    @cards = Card.review
    @card = @cards.offset(rand(@cards.count)).first
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end
end
