class AddDriverToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_reference :appointments, :driver, null: false, foreign_key: true
  end
end
