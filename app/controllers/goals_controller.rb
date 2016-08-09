class GoalsController < ApplicationController

  def index
    user = User.find(params[:user_id])
    @goals = user.goals
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to user_goals_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update(goal_params)
    flash[:errors] = @goal.errors.full_messages
    redirect_to goal_url(@goal)
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :details, :private, :completed)
  end

end
