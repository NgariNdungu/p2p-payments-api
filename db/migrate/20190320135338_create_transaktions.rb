class CreateTransaktions < ActiveRecord::Migration[5.2]
  def change
    create_table :transaktions do |t|
      t.integer :credit_account, :references => "account"
      t.integer :debit_account, :references => "account"
      t.float :ca_balance
      t.float :da_balance
      t.float :amount

      t.timestamps
    end
  end
end
