class AddColumnsToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :content_checked, :boolean
    add_column :notifications, :images_count, :integer
  end
end
