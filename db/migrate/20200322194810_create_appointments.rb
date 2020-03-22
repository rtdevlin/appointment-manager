class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.string :event_id
      t.string :description
      t.date :date
      t.time :start_time
      t.string :location
      t.string :html_link

      t.timestamps
    end
  end
end
