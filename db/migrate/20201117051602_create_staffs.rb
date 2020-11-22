class CreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs do |t|
      t.string :name 
      t.string :dob
      t.string :password_digest
      t.string :is_doctor
    end
  end
end
