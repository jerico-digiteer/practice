class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path
    elsif resource.is_a?(User)
      users_dashboard_path
    else
      super
    end
  end

  def after_sign_up_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path 
    elsif resource.is_a?(User)
      users_dashboard_path 
    else
      super
    end
  end

  def after_update_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path
    elsif resource.is_a?(User)
      users_dashboard_path
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      home_index_path
    elsif resource_or_scope == :user
      home_index_path
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :wallet])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :wallet])
  end

  def current_admin
    current_user.is_a?(Admin)
  end
end
