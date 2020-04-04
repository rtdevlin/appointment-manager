class CreateMessageLines < ActiveRecord::Migration[6.0]
  def change
    create_table :message_lines do |t|
      t.references :message_id
      t.references :appointment_id
      t.integer :order

      t.timestamps
    end
  end
end
