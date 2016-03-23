# frozen_string_literal: true
class DatasetsController < ApplicationController
  before_action :set_dataset, only: [:show, :update]

  api :GET, '/datasets'
  param :page, Integer
  param :per, Integer
  def index
    @datasets = Dataset.page(params[:page]).per(params[:per])

    render json: @datasets, each_serializer: DatasetPreviewSerializer, meta: pagination_dict(@datasets)
  end

  api :GET, '/datasets/:id'
  param :id, Integer, required: true
  def show
    render json: @dataset
  end

  api :PUT, '/dataset/:id'
  param :id, Integer
  param :dataset, Hash do
    param :title, String
  end
  def update
    @dataset.update!(dataset_params)

    render json: @dataset
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dataset
    @dataset = Dataset.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dataset_params
    params.fetch(:dataset, {}).permit(:title)
  end
end
