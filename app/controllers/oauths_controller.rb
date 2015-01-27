class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    begin
      if @user = login_from(provider)
        redirect_to root_path, flash: { success: "Успешный вход с #{provider.titleize}" }
      else
        @user = create_from(provider)

        reset_session
        auto_login(@user)
        redirect_to root_path, flash: { success: "Успешный вход с #{provider.titleize}" }
      end
    rescue
      redirect_to root_path, flash: { error: "Неудалось войти с #{provider.titleize}" }
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
