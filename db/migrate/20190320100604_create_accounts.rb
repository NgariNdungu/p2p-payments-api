class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :balance, null: false, default: 0
      t.boolean :is_agent, null: false, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
