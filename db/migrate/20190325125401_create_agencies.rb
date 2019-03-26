class CreateAgencies < ActiveRecord::Migration[5.2]
  def change
    create_table :agencies do |t|
      t.string :business_name
      t.string :location
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
