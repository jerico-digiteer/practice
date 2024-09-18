class ChangeWalletDefaultInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :wallet, 0
  end
end
