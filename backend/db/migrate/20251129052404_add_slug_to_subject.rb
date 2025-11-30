class AddSlugToSubject < ActiveRecord::Migration[8.0]
  def change
    add_column :subjects, :slug, :string
  end
end
