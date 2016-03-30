# frozen_string_literal: true
class UsersController < ApplicationController
  api :POST, '/users', '注册用户'
  param :user, Hash do
    param :email, String, 'E-mail', required: true
    param :password, String, '密码', required: true
  end
  def create
    @user = User.create!(user_params)

    auth_token = AuthToken.new(@user.id, @user.password_digest).generate
    render json: @user, status: :created, meta: {auth_token: auth_token}
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :password)
  end
end
