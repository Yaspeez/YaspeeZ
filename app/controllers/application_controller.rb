class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :redirect_unonboarded_users

  include Pagy::Backend

  private

  def redirect_unonboarded_users
    redirect_to onboarding_path if current_user && !current_user.onboarded?
  end
end
