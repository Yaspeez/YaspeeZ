# frozen_string_literal: true

module Cities
  class AutocompletesController < ApplicationController
    skip_before_action :redirect_unonboarded_users

    def show
      @cities = City.search(params[:q]).first(10)
      authorize [:city, :autocomplete]
      render layout: false
    end
  end
end
