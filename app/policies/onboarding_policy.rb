class OnboardingPolicy < ApplicationPolicy
  def show?
    user && !user.onboarded?
  end

  def create?
    user && !user.onboarded?
  end
end
