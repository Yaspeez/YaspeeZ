class Activity::ParticipantPolicy < ApplicationPolicy
  def index?
    user.admin? || record.pluck(:user_id).include?(user.id)
  end

  def create?
    user && !record.activity.users.include?(user)
  end

  def destroy?
    user && record.activity.users.include?(user)
  end
end
