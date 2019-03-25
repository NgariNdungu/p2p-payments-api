class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :balance
      t.boolean :is_agent
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
