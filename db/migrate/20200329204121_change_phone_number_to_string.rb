class ChangePhoneNumberToString < ActiveRecord::Migration[6.0]
  def change
    change_column :drivers, :phone_number, :string
  end
end
