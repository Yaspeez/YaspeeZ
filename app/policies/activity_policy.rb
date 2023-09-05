class ActivityPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    user.confirmed?
  end

  def create?
    user.confirmed?
  end

  def new?
    create?
  end

  def update?
    user.admin? || record.owner.eql?(user)
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || record.owner.eql?(user)
  end
end
