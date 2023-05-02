class AthletePolicy < ApplicationPolicy
  def show?
    user.confirmed?
  end
end
