class ChangeBalanceDefaultOnAccount < ActiveRecord::Migration[5.2]
  def change
    change_column_default :accounts, :balance, from: nil, to: 0
  end
end
