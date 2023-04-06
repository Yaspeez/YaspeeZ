# frozen_string_literal: true

module Sports
  class ActivitiesController < ApplicationController
    def new
      @activity = @sport.activities.new
    end

    def create
    end
  end
end

