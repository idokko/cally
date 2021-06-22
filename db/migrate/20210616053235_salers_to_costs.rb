class SalersToCosts < ActiveRecord::Migration[5.2]
  def change
    add_column :costs, :seller_id, :integer
  end
end
