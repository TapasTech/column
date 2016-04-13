# frozen_string_literal: true
class AuthTokensController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]

  api :POST, '/auth_tokens', '登录获取令牌'
  param :user, Hash do
    param :email, String, 'E-mail', required: true
    param :password, String, '密码', required: true
  end
  def create
    @user = User.find_by(email: login_params[:email])
    fail ColumnCustomError::LoginError unless @user&.authenticate(login_params[:password])

    auth_token = AuthToken.new(@user.id, @user.password_digest).generate
    render json: @user, status: :created, meta: {auth_token: auth_token}
  end

  api :GET, '/auth_tokens/:auth_token', '查看令牌的用户信息'
  param :auth_token, String, '认证token', required: true
  def show
    render json: current_user, meta: {auth_token: http_authorization}
  end

  api :PUT, '/auth_tokens/:auth_token', '更新令牌'
  param :auth_token, String, '认证token', required: true
  def update
    @user = current_user
    auth_token = AuthToken.new(@user.id, @user.password_digest).generate
    render json: @user, meta: {auth_token: auth_token}
  end

  private

  def login_params
    params.fetch(:user, {}).permit(:email, :password)
  end
end
