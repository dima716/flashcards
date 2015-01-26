class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = login(auth_params[:email], auth_params[:password])
    if @user
      redirect_back_or_to(:root, success: "Добро пожаловать")
    else
      flash.now[:error] = "Неверный логин или пароль"
      render action: "new"
    end
  end

  def destroy
    logout
    redirect_to(:root, flash: { info: "Произведен выход" })
  end

  def auth_params
    params.permit(:email, :password)
  end
end
