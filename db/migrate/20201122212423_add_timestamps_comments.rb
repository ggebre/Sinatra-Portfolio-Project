class AddTimestampsComments < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :comments, default: Time.now
  end
end
