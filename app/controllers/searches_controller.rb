# frozen_string_literal: true
class SearchesController < ApplicationController
  before_action :set_query_strategy_and_serializer, only: [:show]

  api :GET, '/searches/:type', '查找'
  param :type, String, "Query type, avaliable values:\n- dataset: 数据集", required: true
  param :query, String, 'Query string', required: true
  param :page, String
  param :per, String
  def show
    @results = @strategy.search(params)
                        .page(params[:page]).per(params[:per])

    render json: @results,
           each_serializer: @serializer,
           meta: pagination_dict(@results)
  end

  private

  QUERY_TYPES =
    {
      'dataset' => [DatasetService, DatasetPreviewSerializer]
    }.freeze

  def set_query_strategy_and_serializer
    @strategy, @serializer = QUERY_TYPES[params[:type]]

    fail 'Undefined query type' if @strategy.nil? || @serializer.nil?
  end
end
