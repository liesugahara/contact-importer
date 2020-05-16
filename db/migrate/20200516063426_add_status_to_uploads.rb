class AddStatusToUploads < ActiveRecord::Migration[6.0]
  def change
    add_column :uploads, :status, :string
  end
end
