class DecksController < ApplicationController
  before_action :get_deck, only: [:show, :edit, :update, :destroy, :check]

  def index
    @decks = current_user.decks
  end

  def edit
  end

  def show
    @cards = @deck.cards
    render "cards/index"
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.new(deck_params)

    set_current_deck

    if @deck.save
      redirect_to decks_path
    else
      render "new"
    end
  end

  def update
    set_current_deck

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
    params.require(:deck).permit(:name, :picture, :current)
  end

  def set_current_deck
    if parse_boolean(deck_params[:current]) && parse_boolean(deck_params[:current]) != parse_boolean(@deck.current_was)
      if current_user.decks.current_deck.present?
        @deck.change_current_deck(current_user.decks.current_deck.first)
      end
    end
  end
end
