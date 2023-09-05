# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    @activities = current_user.activities.future.order(:starts_at)
    authorize(:dashboard, :show?)
  end
end
