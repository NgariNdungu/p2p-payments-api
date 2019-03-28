class CreateTransaktions < ActiveRecord::Migration[5.2]
  def change
    create_table :transaktions do |t|
      t.references :account, foreign_key: true
      t.string :trans_set
      t.float :balance
      t.string :trans_type
      t.float :amount

      t.timestamps
    end
  end
end
