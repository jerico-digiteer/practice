class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Redirect to respective dashboards after sign-in
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path # Path to the admin dashboard
    elsif resource.is_a?(User)
      users_dashboard_path # Path to the user dashboard (Assuming this is defined)
    else
      super
    end
  end

  # Redirect to respective dashboards after sign-up
  def after_sign_up_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path 
    elsif resource.is_a?(User)
      users_dashboard_path 
    else
      super
    end
  end

    # Redirect to respective dashboards after profile update
    def after_update_path_for(resource)
      if resource.is_a?(Admin)
        admin_dashboard_path
      elsif resource.is_a?(User)
        users_dashboard_path
      else
        super
      end
    end

  # Redirect to respective login pages after sign-out
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path # Redirect to the admin login page
    elsif resource_or_scope == :user
      new_user_session_path # Redirect to the user login page
    else
      super
    end
  end

  # Configure additional permitted parameters for sign-up and account update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :wallet])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :wallet])
  end
end
