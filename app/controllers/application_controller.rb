class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

 before_action :allowed_params, if: :devise_controller?

 protected

  def allowed_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
 end
end