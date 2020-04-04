class RenameColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :message_lines, :message_id_id, :message_id
    rename_column :message_lines, :appointment_id_id, :appointment_id
  end
end
