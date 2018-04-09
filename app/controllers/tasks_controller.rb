class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :comfirm_current_user, only: [:show, :edit, :update, :destroy]
  
  def index
    # @tasks = Task.all.page(params[:page]).per(10)
    # @user = current_user
    @tasks = current_user.tasks.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    # @task = Task.new(task_params)
    #@task = Task.new(content:'test', status:'test2', user_id:'current_user.user_id')
    @task = current_user.tasks.new(task_params)

    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    # if current_user == @task.user
    #   @task.destroy
    #   flash[:success] = 'Task は正常に削除されました'
    # else
    #   flash[:success] = 'Task は削除されませんでした'
    # end

    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  def comfirm_current_user
    if current_user != @task.user
      # 強制ログアウト
      session[:user_id] = nil
      # ログインページへ遷移
      redirect_to login_url
    end
  end

  def set_task
    @task = Task.find(params[:id])
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
