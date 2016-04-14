# frozen_string_literal: true
class CSVFilesController < ApplicationController
  before_action :set_csv_file, only: [:show, :destroy, :download]

  api :GET, '/csv_files/:id', '查看CSV文件'
  param :id, String, required: true
  def show
    render json: @csv_file
  end

  api :POST, '/csv_files', '上传CSV文件'
  param :file, ::ActionDispatch::Http::UploadedFile, required: true
  def create
    @csv_file =
      current_user.present? ? current_user.csv_files.build : CSVFile.new
    @csv_file.csv = params[:file]
    @csv_file.save!

    # TODO: perform_later
    ProcessCSVJob.perform_now(@csv_file.id)

    render json: @csv_file.reload, status: :created, location: @csv_file
  end

  def download
    path, type = case params[:format]
                 when 'csv'
                   [@csv_file.path, 'text/csv']
                 when 'xls'
                   [@csv_file.convert_to_excel_file.path, 'application/excel']
                 end

    send_file path, filename: "#{@csv_file.title}.#{params[:format]}", type: type
  end

  def destroy
    @csv_file
  end

  private

  def set_csv_file
    @csv_file = CSVFile.find(params[:id])
  end
end
