# frozen_string_literal: true
class AuthTokensController < ApplicationController
  before_action :authenticate_user!, only: [:update]

  api :POST, '/auth_tokens'
  param :user, ActionController::Parameters, '用户' do
    param :email, String, 'E-mail', required: true
    param :password, String, '密码', required: true
  end
  def create
    @user = User.find_by(email: login_params[:email])
    fail ColumnCustomError::LoginError unless @user&.authenticate(login_params[:password])

    auth_token = AuthToken.new(@user.id, @user.password_digest).generate
    render json: @user, status: :created, meta: {auth_token: auth_token}
  end

  api :PUT, '/auth_tokens/:auth_token'
  param :auth_tokens, String, '要替换的认证token', required: true
  def update
    @user = current_user
    auth_token = AuthToken.new(@user.id, @user.password_digest).generate
    render json: @user, status: :created, meta: {auth_token: auth_token}
  end

  private

  def login_params
    params.fetch(:user, {}).permit(:email, :password)
  end
end
