class CreateCats < ActiveRecord::Migration[6.1]
  def change
    create_table :cats do |t|
      t.string :cat_url
      t.string :breed_name
      t.references :breed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
