class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.order(limit: :desc).page(params[:page]).per(5)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :desc).page(params[:page]).per(5)
    elsif params[:search]
      if params[:search_title].present? && params[:search_status].present? && params[:search_label].present?
        @tasks = current_user.tasks.search_title(params[:search_title]).search_status(params[:search_status]).search_label(params[:search_label]).page(params[:page]).per(5)
      elsif params[:search_title].present? && params[:search_status].present?
        @tasks = current_user.tasks.search_title(params[:search_title]).search_status(params[:search_status]).page(params[:page]).per(5)
      elsif params[:search_status].present? && params[:search_label].present?
        @tasks = current_user.tasks.search_status(params[:search_status]).search_label(params[:search_label]).page(params[:page]).per(5)
      elsif params[:search_title].present? && params[:search_label].present?
        @tasks = current_user.tasks.search_title(params[:search_title]).search_label(params[:search_label]).page(params[:page]).per(5)
      elsif params[:search_title].present?
        @tasks = current_user.tasks.search_title(params[:search_title]).page(params[:page]).per(5)
      elsif params[:search_status].present?
        @tasks = current_user.tasks.search_status(params[:search_status]).page(params[:page]).per(5)
      elsif params[:search_label].present?
        @tasks = current_user.tasks.search_label(params[:search_label]).page(params[:page]).per(5)
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
        redirect_to tasks_path, notice: "???????????????????????????????????????"
      else
      render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "???????????????????????????????????????"
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
    redirect_to tasks_path, notice:"?????????????????????????????????"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :limit, :status_name, :priority, :user_id, { label_ids: [] })
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
