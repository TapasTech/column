# frozen_string_literal: true
class CSVFilesController < ApplicationController
  before_action :set_csv_file, only: [:show, :destroy]

  api :GET, '/csv_files/:id', '查看CSV文件'
  param :id, String, required: true
  def show
    respond_to do |format|
      format.xls { download('xls') }
      format.csv { download('csv') }
      format.json { render json: @csv_file }
    end
  end

  api :POST, '/csv_files', '上传CSV文件'
  param :file, ::ActionDispatch::Http::UploadedFile, required: true
  def create
    @csv_file =
      current_user.present? ? current_user.csv_files.build : CSVFile.new
    @csv_file.csv = params[:file]
    @csv_file.filename = params[:file].original_filename.split('.').first
    @csv_file.save!

    # TODO: perform_later
    ProcessCSVJob.perform_now(@csv_file.id)

    render json: @csv_file.reload, status: :created, location: @csv_file
  end

  def destroy
    @csv_file
  end

  private

  def set_csv_file
    @csv_file = CSVFile.find(params[:id])
  end

  def download(format)
    encoding = CSVParser.new(@csv_file).encoding

    case format
      when 'csv'
        data, type =[@csv_file.csv_data, "text/csv; charset=#{encoding}"]
        send_data data, filename: "#{@csv_file.filename}.#{format}", type: type
      when 'xls'
        path, type = [@csv_file.convert_to_excel_file.path, "application/excel; charset=#{encoding}"]
        send_file path, filename: "#{@csv_file.filename}.#{format}", type: type
    end
  end
end
