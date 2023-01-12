class Managers::DashboardController < ApplicationController
  before_action :authenticate_user!

  def manager?
    return if current_user.has_role? :manager

    redirect_to buyers_path
  end

  def index
    @features = Feature.count
    @plans = Plan.count
    @invitees = current_user.buyers.count
  end

  def invitees
    @invitees = current_user.buyers
  end
end
