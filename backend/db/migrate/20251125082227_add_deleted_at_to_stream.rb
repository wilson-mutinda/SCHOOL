class AddDeletedAtToStream < ActiveRecord::Migration[8.0]
  def change
    add_column :streams, :deleted_at, :datetime
  end
end
