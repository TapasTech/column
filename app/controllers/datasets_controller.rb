# frozen_string_literal: true
class DatasetsController < ApplicationController
  before_action :set_dataset, only: [:show]

  # GET /datasets
  def index
    @datasets = Dataset.page(params[:page]).per(params[:per])

    render json: @datasets, each_serializer: DatasetPreviewSerializer, meta: pagination_dict(@datasets)
  end

  # GET /datasets/1
  def show
    render json: @dataset
  end

  # POST /datasets
  def create
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dataset
    @dataset = Dataset.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dataset_params
    params.fetch(:dataset, {}).permit(:title, :file)
  end
end
