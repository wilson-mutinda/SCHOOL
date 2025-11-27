class CreateLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :levels do |t|
      t.string :name
      t.references :stream, null: false, foreign_key: true

      t.timestamps
    end
  end
end
