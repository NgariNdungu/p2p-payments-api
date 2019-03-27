# Start agency ids at 10001
# Migration is irreversible
# TODO: move to agency creation migration
class ChangeIdSequenceOnAgency < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      ALTER SEQUENCE agencies_id_seq
        START 10001
        MINVALUE 10001
        RESTART
    SQL
  end
end
