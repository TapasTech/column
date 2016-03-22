# frozen_string_literal: true
class CSVFilesController < ApplicationController
  before_action :set_csv_file, only: [:show, :destroy]

  def show
    render json: @csv_file
  end

  def create
    @csv_file = CSVFile.new
    @csv_file.csv = params[:file]
    @csv_file.save!

    ProcessCSVJob.perform_later(@csv_file.id)

    render json: @csv_file, status: :created
  end

  def destroy
  end

  private

  def set_csv_file
    @csv_file = CSVFile.find(params[:id])
  end
end
