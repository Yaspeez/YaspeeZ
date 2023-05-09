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

  def destroy?
    user.eql?(record)
  end
end
