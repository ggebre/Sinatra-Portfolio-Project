class AddAppointmentDateToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :appointment_date, :string 
  end
end
