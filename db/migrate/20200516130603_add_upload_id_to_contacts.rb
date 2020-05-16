class AddUploadIdToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :upload_id, :int

  end
end
