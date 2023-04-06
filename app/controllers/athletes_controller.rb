# frozen_string_literal: true

class AthletesController < ApplicationController
  def show
    @athlete = User.includes(:participations).find(params[:id])
    @next_organized_activities = @athlete.organized_activities.future
  end
end

