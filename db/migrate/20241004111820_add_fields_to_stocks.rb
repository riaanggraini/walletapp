class AddFieldsToStocks < ActiveRecord::Migration[7.2]
  def change
    add_column :stocks, :change, :decimal, precision: 15, scale: 2
    add_column :stocks, :day_high, :decimal, precision: 15, scale: 2
    add_column :stocks, :day_low, :decimal, precision: 15, scale: 2
    add_column :stocks, :last_update_time, :string
    add_column :stocks, :company_name, :string
    add_column :stocks, :industry, :string
    add_column :stocks, :isin, :string
    add_column :stocks, :open_price, :decimal, precision: 15, scale: 2
    add_column :stocks, :p_change, :decimal, precision: 5, scale: 2
    add_column :stocks, :per_change_30d, :decimal, precision: 5, scale: 2
    add_column :stocks, :per_change_365d, :decimal, precision: 5, scale: 2
    add_column :stocks, :previous_close, :decimal, precision: 15, scale: 2
    add_column :stocks, :total_traded_value, :decimal, precision: 20, scale: 2
    add_column :stocks, :total_traded_volume, :integer
    add_column :stocks, :year_high, :decimal, precision: 15, scale: 2
    add_column :stocks, :year_low, :decimal, precision: 15, scale: 2
    rename_column :stocks, :ticker, :symbol
  end
end
