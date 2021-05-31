class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]#終了日の降順ソート
      @tasks = Task.order(limit: :desc)
    elsif params[:sort_priority]
      @tasks = Task.order(priority: :desc)
    elsif params[:search]#タイトルのあいまい検索
      if params[:search_title].present? && params[:search_status].present?
        @tasks = Task.where("title LIKE ?", "%#{params[:search_title]}%").where(status_name: params[:search_status])
      elsif params[:search_title].present?  && params[:search_status].blank?
        @tasks = Task.where("title LIKE ?", "%#{params[:search_title]}%")
      elsif params[:search_title].blank? && params[:search_status].present?
        @tasks = Task.where(status_name: params[:search_status])
      else
        @tasks = Task.order(created_at: :desc)
      end
    else
      @tasks = Task.order(created_at: :desc)#新規タスクの投稿日昇順ソート
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました。"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :limit, :status_name, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
