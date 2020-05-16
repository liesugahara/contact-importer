class AddUserIdToUploads < ActiveRecord::Migration[6.0]
  def change
    add_column :uploads, :user_id, :int
  end
end
