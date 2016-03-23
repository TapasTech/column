# frozen_string_literal: true
class SearchesController < ApplicationController
  before_action :set_query_strategy_and_serializer, only: [:show]

  api :GET, '/searches/:type'
  param :type, String, required: true
  param :query, String, required: true
  def show
    @results = @strategy.search(params)

    render json: @results, each_serializer: @serializer
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
