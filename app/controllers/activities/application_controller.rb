# frozen_string_literal: true

class Activities::ApplicationController < ApplicationController
  before_action :set_activity

  private

  def set_activity
    @activity = Activity.find(params[:activity_id])
  end
end

