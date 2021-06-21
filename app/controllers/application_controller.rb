class ApplicationController < ActionController::Base
#permit additional parameters.
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:user_update, keys: [:username, :first_name, :last_name, :avatar, :description, :website ])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name, :email, :password, :avatar, :description, :website ])
    end

    
end
