class AddDeletedAtToLevel < ActiveRecord::Migration[8.0]
  def change
    add_column :levels, :deleted_at, :datetime
  end
end
