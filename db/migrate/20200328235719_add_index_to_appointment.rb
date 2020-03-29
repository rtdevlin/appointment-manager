class AddIndexToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_index :appointments, :event_id, unique: true
  end
end
