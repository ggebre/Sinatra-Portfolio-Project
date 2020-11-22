class CreatePrescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :prescriptions do |t|
      t.string :name 
      t.string :description 
      t.integer :appointment_id
      t.integer :patient_id
    end
  end
end
