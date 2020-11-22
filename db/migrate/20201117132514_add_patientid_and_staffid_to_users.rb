class AddPatientidAndStaffidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :patient_id, :integer
    add_column :users, :staff_id, :integer
  end
end
