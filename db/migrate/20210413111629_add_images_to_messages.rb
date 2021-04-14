class AddImagesToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :images, :json
  end
end
