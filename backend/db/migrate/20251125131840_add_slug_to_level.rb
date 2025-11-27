class AddSlugToLevel < ActiveRecord::Migration[8.0]
  def change
    add_column :levels, :slug, :string
  end
end
