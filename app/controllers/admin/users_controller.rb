class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.select(:id, :name).page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id), notice: "ユーザー情報を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: "ユーザー情報を編集しました"
    else
      render :edit
    end
  end

  def show
    @tasks = @user.tasks.page(params[:page]).per(5)
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:"ユーザー情報を削除しました"
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation, :admin)
  end

  def if_not_admin
    redirect_to root_path unless current_user.admin == "管理者"
  end
end
