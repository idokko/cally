class CreateMessageImages < ActiveRecord::Migration[5.2]
  def change
    create_table :message_images do |t|
      t.integer :message_id
      t.string :photos

      t.timestamps
    end
  end
end
