class AddStripeAccountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :access_code, :string
    add_column :users, :publishable_key, :string
  end
end
