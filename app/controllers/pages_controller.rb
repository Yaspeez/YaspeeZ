# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  layout "devise", only: [:home]

  def activities; end
  def home; end
  def privacy; end
  def profile; end
  def terms; end
end
