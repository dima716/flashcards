class CardsController < ApplicationController
  before_action :get_deck, except: [:check]
  before_action :get_card, only: [:check, :edit, :update, :destroy]

  def new
    @card = @deck.cards.new
    @card.user = current_user
  end

  def create
    @card = @deck.cards.new(card_params)
    @card.user = current_user

    if @card.save
      redirect_to deck_cards_path
    else
      render "new"
    end
  end

  def index
  end

  def check
    if @card.check_translation(params[:user_text])
      @card.update_attributes(successful_checks_counter: @card.successful_checks_counter + 1,
                              unsuccessful_checks_counter: 0)
      @card.update_review_date

      flash[:success] = "Правильно"
    elsif @card.successful_checks_counter == 0
      flash[:error] = "Неправильно"
    else
      @card.update_attribute(:unsuccessful_checks_counter, @card.unsuccessful_checks_counter + 1)

      if @card.unsuccessful_checks_counter == 3
        @card.update_attributes(unsuccessful_checks_counter: 0, successful_checks_counter: 0)
      end

      flash[:error] = "Неправильно"
    end

    redirect_to root_path
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to deck_cards_path
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to deck_cards_path
  end

  private

  def get_card
    unless @card = current_user.cards.where(id: params[:id]).first
      redirect_to root_path
    end
  end

  def get_deck
    unless @deck = current_user.decks.where(id: params[:deck_id]).first
      redirect_to root_path
    end
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :picture, :deck_id)
  end
end
