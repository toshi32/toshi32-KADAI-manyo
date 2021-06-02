class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]#終了日の降順ソート
      @tasks = current_user.tasks.order(limit: :desc).page(params[:page]).per(5)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :desc).page(params[:page]).per(5)
    elsif params[:search]#タイトルのあいまい検索
      if params[:search_title].present? && params[:search_status].present?
        @tasks = current_user.tasks.where("title LIKE ?", "%#{params[:search_title]}%").where(status_name: params[:search_status]).page(params[:page]).per(5)
      elsif params[:search_title].present?  && params[:search_status].blank?
        @tasks = current_user.tasks.where("title LIKE ?", "%#{params[:search_title]}%").page(params[:page]).per(5)
      elsif params[:search_title].blank? && params[:search_status].present?
        @tasks = current_user.tasks.where(status_name: params[:search_status]).page(params[:page]).per(5)
      else
        @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(5)
      end
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(5)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "新規タスクを作成しました。"
      else
      render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクの編集を行いました。"
    else
      render :edit
    end
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  def show
    # @task = Task.find_by(id: params[:id])
    # @user = User.find_by(id: @task.user_id)
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました。"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :limit, :status_name, :priority, :user_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
