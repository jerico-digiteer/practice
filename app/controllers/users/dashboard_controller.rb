class Users::DashboardController < ApplicationController
    before_action :authenticate_user!
    
    def index
      # User-specific logic
    end
  end
  