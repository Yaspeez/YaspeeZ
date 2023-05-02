class ProfilePolicy < ApplicationPolicy
  def show?
    user
  end

  def update?
    user
  end

  def edit?
    update?
  end
end
