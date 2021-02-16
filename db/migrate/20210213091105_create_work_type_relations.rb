class CreateWorkTypeRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :work_type_relations do |t|
      t.references :work, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end
