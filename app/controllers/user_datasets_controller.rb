# frozen_string_literal: true
class UserDatasetsController < ApplicationController
  before_action :set_user
  api :GET, '/users/:user_id/datasets', '查看用户上传的数据集'
  param :user_id, String, '用户ID', required: true
  param :page, String
  param :per, String
  def index
    @datasets = @user.datasets.page(params[:page]).per(params[:per])
    render json: @datasets,
           each_serializer: DatasetPreviewSerializer,
           meta: pagination_dict(@datasets)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
