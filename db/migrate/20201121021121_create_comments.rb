class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :patient_id
      t.integer :staff_id
    end
  end
end
