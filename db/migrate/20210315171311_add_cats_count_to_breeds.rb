class AddCatsCountToBreeds < ActiveRecord::Migration[6.1]
  def change
    add_column :breeds, :cats_count, :integer, default: 0
  end
end
