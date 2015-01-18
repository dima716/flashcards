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

  def check
    if @card.check_translation(params[:user_text])
      flash[:success] = "Правильно"
    else
      flash[:error] = "Неправильно"
    end

    redirect_to root_path
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

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end
end
