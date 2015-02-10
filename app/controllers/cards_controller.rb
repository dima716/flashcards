require 'super_memo_2'

class CardsController < ApplicationController
  before_action :get_deck, except: [:check, :review]
  before_action :get_card, only: [:check, :review, :edit, :update, :destroy]

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
    typos_number = @card.check_translation(params[:user_text])

    case typos_number
    when 0
      flash.now[:success] = "Правильно"
    when 1..3
      flash.now[:success] = "Правильно. Была исправлена опечатка в слове '#{params[:user_text]}'"
    else
      if typos_number > 3
        flash.now[:error] = "Неправильно"
      end
    end

    render "show"
  end

  def review
    attributes = SuperMemo2.new(score: params[:score].to_i,
                                repetition_number: @card.repetition_number,
                                repetition_interval: @card.repetition_interval,
                                ef: @card.ef).review

    if @card.update(attributes)
      redirect_to root_path
    else
      render "review"
    end
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
