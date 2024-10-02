class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.references :user, foreign_key: { on_delete: :restrict }, null: true
      t.references :team, foreign_key: { on_delete: :restrict }, null: true
      t.references :stock, foreign_key: { on_delete: :restrict }, null: true
      t.decimal :balance, precision: 15, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
