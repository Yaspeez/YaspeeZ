class AthletePolicy < ApplicationPolicy
  def show?
    user.confirmed? || user.eql?(record)
  end
end
