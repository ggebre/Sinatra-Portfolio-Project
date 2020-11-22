class AddDiagnosisToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :diagnosis_note, :string 
  end
end
