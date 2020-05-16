class Upload < ApplicationRecord
  belongs_to :user
  serialize :headers
  has_attached_file :csv,
                    path: 'csv/:id.csv',
                    s3_headers: lambda { |attachment|
                      {
                        'Content-Type' => 'text/csv',
                        'Content-Disposition' => "attachment; filename=#{attachment.csv_file_name}"
                      }
                    }
do_not_validate_attachment_file_type :csv
# validates_attachment_content_type :csv, content_type: ['text/csv']




  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end