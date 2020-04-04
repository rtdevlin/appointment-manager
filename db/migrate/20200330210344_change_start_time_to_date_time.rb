class ChangeStartTimeToDateTime < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :start_time
    add_column :appointments, :start_time, :datetime
  end
end
