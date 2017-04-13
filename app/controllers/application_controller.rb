class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.home_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_out_path_for(resource)
    home_path
  end

  def disable_nav
    @disable_nav = true
  end

end
