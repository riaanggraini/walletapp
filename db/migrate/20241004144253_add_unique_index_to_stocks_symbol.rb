class AddUniqueIndexToStocksSymbol < ActiveRecord::Migration[7.0]
  def change
    add_index :stocks, :symbol, unique: true
  end
end
