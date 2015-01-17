class CardsController < ApplicationController
  before_action :get_card, only: [:edit, :update, :destroy, :check]

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

  def random
    get_random_card
  end

  def check
    if @card.equale(params[:user_text])
      flash[:notice] = "Правильно"
    else
      flash[:notice] = "Неправильно"
    end

    redirect_to random_card_path
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
