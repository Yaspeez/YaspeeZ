class Activity::CommentPolicy < ApplicationPolicy
  def create?
    user && record.activity.users.include?(user)
  end

  def update?
    create?
  end

  def destroy?
    user.admin? || record.author.eql?(user)
  end
end
