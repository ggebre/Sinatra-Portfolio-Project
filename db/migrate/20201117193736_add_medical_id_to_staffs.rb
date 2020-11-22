class AddMedicalIdToStaffs < ActiveRecord::Migration[6.0]
  def change
      add_column :staffs, :medical_id, :string 
  end
end
