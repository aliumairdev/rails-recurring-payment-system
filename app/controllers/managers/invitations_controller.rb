class Managers::InvitationsController < Devise::InvitationsController
  before_action :manager?, only: [:new, :create]

  def manager?
    return if current_user.has_role? :manager

    redirect_to root_path, alert: 'You are not authorized to perform this action.'
  end
end
