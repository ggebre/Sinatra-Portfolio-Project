class RemovePasswordDigestFromStaffs < ActiveRecord::Migration[6.0]
  def change
    remove_column :staffs, :password_digest, :string
  end
end
