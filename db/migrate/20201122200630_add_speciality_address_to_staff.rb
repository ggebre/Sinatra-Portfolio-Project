class AddSpecialityAddressToStaff < ActiveRecord::Migration[6.0]
  def change
    add_column :staffs, :speciality, :string 
    add_column :staffs, :address, :string 
    add_column :staffs, :phone, :string 
  end
end

