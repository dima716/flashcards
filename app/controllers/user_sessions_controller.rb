class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(auth_params[:email], auth_params[:password])
      redirect_back_or_to root_path, success: "Добро пожаловать"
    else
      flash.now[:error] = "Неверный логин или пароль"
      render "new"
    end
  end

  def destroy
    logout
    redirect_to root_path, flash: { info: "Произведен выход" }
  end

  def auth_params
    params.permit(:email, :password)
  end
end
