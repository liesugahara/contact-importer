class UploadsController < ApplicationController
  require 'csv'

  # skip_before_action :verify_authenticity_token

  def index
    @csvs = Upload.paginate(page: params[:csvs_pg], per_page: 10)
  end

  def csv_file
    p params
    headers = {
      name: params[:name],
      dob: params[:dob],
      phone: params[:phone],
      address: params[:address],
      credit_card: params[:credit_card],
      email: params[:email]
    }
    # p headers
    extension = File.extname(params[:file].original_filename)
    p extension
    return flash.now[:alert]  = "The file must be a cvs" if extension != ".csv"
    file = params[:file]
    csv_file = Upload.new()
    file = File.read(file)
    file = StringIO.new(file)
    csv_file.csv = file
    csv_file.headers = headers
    csv_file.user = current_user
    csv_file.status = "On Hold"
    csv_file.save!
    upload_id = csv_file.id
    p upload_id
    Contact.import(params[:file], headers, current_user, upload_id)
    redirect_to uploads_path, notice: "File imported."
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end
end
