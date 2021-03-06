class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_url, flash: { success: "Пользователь успешно создан" }
    else
      render "new"
    end
  end

  def set_current_deck
    @deck = current_user.decks.where(id: params[:id]).first

    if @deck.cards.present?
      current_user.update_attribute(:current_deck_id, @deck.id)
    else
      flash[:error] = "Нельзя сделать колоду текущей, если в ней нет карточек"
    end

    redirect_to decks_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, authentications_attributes: [:user_id, :provider, :uid])
  end
end
