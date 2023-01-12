class FeaturePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.has_role? :manager
        scope.where(manager: user)
      else
        scope.where(manager: user.manager)
      end
    end
  end

  def new?
    user.has_role? :manager
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end
