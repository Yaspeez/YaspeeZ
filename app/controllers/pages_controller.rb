# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout "devise", only: [:home]

  def home; end
  def privacy; end
  def terms; end
end
