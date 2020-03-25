class ChangeReferenceToNullable < ActiveRecord::Migration[6.0]
  def change
    change_column_null :appointments, :driver_id, true
  end
end
