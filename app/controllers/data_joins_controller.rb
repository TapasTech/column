# frozen_string_literal: true
class DataJoinsController < ApplicationController
  before_action :set_datasets, only: [:create]

  api :POST, '/data_joins', '交叉对比数据'
  param :dataset, Hash, '表1' do
    param :id, Integer, 'ID'
    param :join_attribute, String, '对标字段'
    param :attribute, String, '对比字段'
  end
  param :compare, Hash, '表2' do
    param :id, Integer, 'ID'
    param :join_attribute, String, '对标字段'
    param :attribute, String, '对比字段'
  end
  def create
    @data_joins =
      Rails.cache.fetch("joins/#{dataset_params.to_json}/#{compare_params.to_json}") do
        Dataset.join_dataset(@dataset, @compare, join_attribute: dataset_params[:join_attribute],
                                                 compare_join_attribute: compare_params[:join_attribute],
                                                 attribute: dataset_params[:attribute],
                                                 compare_attribute: compare_params[:attribute])
               .to_a
      end

    render json: DataJoin.wrap(*@data_joins)
  end

  private

  def dataset_params
    params.fetch(:dataset, {}).permit(:id, :join_attribute, :attribute)
  end

  def compare_params
    params.fetch(:compare, {}).permit(:id, :join_attribute, :attribute)
  end

  def set_datasets
    @dataset = Dataset.find(dataset_params[:id])
    @compare = Dataset.find(compare_params[:id])
  end
end
