class DropDateColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :date
  end
end
