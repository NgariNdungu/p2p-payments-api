class CreateTransaktions < ActiveRecord::Migration[5.2]
  def change
    create_table :transaktions do |t|
      t.integer :credit_account
      t.integer :debit_account
      t.float :ca_balance
      t.float :da_balance
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
