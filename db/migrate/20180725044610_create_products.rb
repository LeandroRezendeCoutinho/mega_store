class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :base_price
      t.integer :stock
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
