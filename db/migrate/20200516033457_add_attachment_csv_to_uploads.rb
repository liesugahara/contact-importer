class AddAttachmentCsvToUploads < ActiveRecord::Migration[5.1]
  def self.up
    change_table :uploads do |t|
      t.attachment :csv
    end
  end

  def self.down
    remove_attachment :uploads, :csv
  end
end
