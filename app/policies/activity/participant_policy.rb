class Activity::ParticipantPolicy < ApplicationPolicy
  def index?
    user.admin? || record.activity.users.include?(user)
  end

  def create?
    user && !record.activity.users.include?(user)
  end

  def destroy?
    user && record.activity.users.include?(user)
  end
end
