class AddAccountPolymorphicAssociation < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :owner_id, :integer
    add_column :accounts, :owner_type, :string
    remove_column :accounts, :user_id, :integer    
  end
end
