class DecksController < ApplicationController
  before_action :get_deck, only: [:show, :edit, :update, :destroy, :check, :set_current_deck]

  def index
    @decks = current_user.decks
  end

  def set_current_deck
    if @deck.cards.present?
      current_user.update_attribute(:current_deck_id, @deck.id)
    else
      flash[:error] = "Нельзя сделать колоду текущей, если в ней нет карточек"
    end

    redirect_to decks_path
  end

  def edit
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.new(deck_params)

    if @deck.save
      redirect_to decks_path
    else
      render "new"
    end
  end

  def update
    if @deck.update(deck_params)
      redirect_to decks_path
    else
      render "edit"
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path
  end

  private

  def get_deck
    unless @deck = current_user.decks.where(id: params[:id]).first
      redirect_to root_path
    end
  end

  def deck_params
    params.require(:deck).permit(:name, :picture)
  end
end
