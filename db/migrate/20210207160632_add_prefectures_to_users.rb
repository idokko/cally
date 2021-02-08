class AddPrefecturesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :prefectures, :integer
  end
end
