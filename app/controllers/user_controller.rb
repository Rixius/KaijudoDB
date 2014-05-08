class UserController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  private
  def set_user
    @user = User.where('username = ?', params[:username].downcase).first
  end
end
