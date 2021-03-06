class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, flash: { error: "Пожалуйста, войдите для просмотра страницы" }
  end

  def current_deck
    current_user.current_deck
  end

  helper_method :current_deck
end
