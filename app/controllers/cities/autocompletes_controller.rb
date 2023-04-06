# frozen_string_literal: true

module Cities
  class AutocompletesController < ApplicationController
    def show
      @cities = City.search(params[:q]).first(10)
      render layout: false
    end
  end
end
