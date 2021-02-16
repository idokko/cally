class CreateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :types do |t|
      t.integer :user_id
      t.integer :work_id
      t.string :work_type

      t.timestamps
    end
  end
end
