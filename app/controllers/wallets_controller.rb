class WalletsController < ApplicationController
    before_action :authenticate_user!
  
    # GET /wallet
    def show
      @user = current_user
    end
  
    # PATCH/PUT /wallet
    def update
      @user = current_user
      amount = params[:amount].to_f
  
      if amount > 0
        @user.wallet += amount
        if @user.save
          redirect_to wallet_path, notice: 'Funds were successfully added to your wallet.'
        else
          redirect_to wallet_path, alert: 'There was an issue adding funds to your wallet.'
        end
      else
        redirect_to wallet_path, alert: 'Invalid amount. Please enter a positive number.'
      end
    end
  end
  