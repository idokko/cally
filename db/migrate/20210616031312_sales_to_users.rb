class SalesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sale, :integer
  end
end
