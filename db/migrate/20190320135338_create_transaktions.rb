class CreateTransaktions < ActiveRecord::Migration[5.2]
  def change
    create_table :transaktions do |t|
      t.integer :account, :references => "account"
      t.string :trans_set
      t.float :balance
      t.string :trans_type
      t.float :amount

      t.timestamps
    end
  end
end
