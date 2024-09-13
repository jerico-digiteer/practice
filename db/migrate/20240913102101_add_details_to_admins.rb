class AddDetailsToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :first_name, :string
    add_column :admins, :last_name, :string
    add_column :admins, :phone_number, :string
    add_column :admins, :wallet, :decimal
  end
end
