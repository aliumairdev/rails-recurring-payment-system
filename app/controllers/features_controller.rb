class FeaturesController < ApplicationController
  before_action :authenticate_user!

  def index
    @features = policy_scope(Feature).all
  end

  def show
    @feature = policy_scope(Feature).find(params[:id])
  end

  def new
    @feature = Feature.new
    authorize @feature
  end

  def create
    @feature = current_user.features.build(feature_params)
    authorize @feature
    if @feature.save
      redirect_to @feature
    else
      render 'new'
    end
  end

  def edit
    @feature = policy_scope(Feature).find params[:id]
    authorize @feature
  end

  def update
    @feature = policy_scope(Feature).find params[:id]
    if @feature.update(feature_params)
      redirect_to @feature
    else
      render 'edit'
    end
  end

  def destroy
    authorize Feature
    Feature.find(params[:id]).destroy
    redirect_to features_path
  end

  private

  def feature_params
    params.required(:feature).permit(:name, :code, :max_unit_limit, :unit_price)
  end
end
