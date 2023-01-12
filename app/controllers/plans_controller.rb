class PlansController < ApplicationController
  def index
    @plans = policy_scope(Plan).includes(:features).all
  end

  def show
    @plan = policy_scope(Plan).includes(:features).find(params[:id])
  end

  def new
    @plan = Plan.new
    @features = policy_scope(Feature)
    authorize @plan
  end

  def create
    @plan = current_user.plans.build(plan_params)
    authorize @plan
    if @plan.save
      redirect_to @plan
    else
      render 'new'
    end
  end

  def edit
    @plan = Plan.find_by params[:id]
    @features = current_user.features
    authorize @plan
  end

  def update
    @plan = current_user.plans.find(params[:id])
    authorize @plan
    if @plan.update(plan_params)
      redirect_to @plan
    else
      render 'edit'
    end
  end

  def destroy
    authorize Plan
    Plan.find(params[:id]).destroy
    redirect_to plans_path
  end

  private

  def plan_params
    params.required(:plan).permit(:name, feature_ids: [])
  end
end
