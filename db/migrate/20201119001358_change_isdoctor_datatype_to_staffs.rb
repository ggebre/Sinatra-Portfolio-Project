class ChangeIsdoctorDatatypeToStaffs < ActiveRecord::Migration[6.0]
  def change
    change_column :staffs, :is_doctor, :boolean
  end
end
