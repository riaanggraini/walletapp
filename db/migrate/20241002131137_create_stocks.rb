class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :ticker, null: false
      t.decimal :price, precision: 15, scale: 2, null: false

      t.timestamps
    end
  end
end
