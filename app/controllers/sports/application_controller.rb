# frozen_string_literal: true

class Sports::ApplicationController < ApplicationController
  before_action :set_sport

  private

  def set_sport
    @sport = Sport.find(params[:sport_id])
  end
end

