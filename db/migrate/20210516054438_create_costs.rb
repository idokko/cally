class CreateCosts < ActiveRecord::Migration[5.2]
  def change
    create_table :costs do |t|
      t.integer :user_id
      t.integer :room_id
      t.integer :price

      t.timestamps
    end
  end
end
