class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :redirect_unonboarded_users

  after_action :verify_authorized, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def redirect_unonboarded_users
    redirect_to onboarding_path if current_user && !current_user.onboarded?
  end

  def user_not_authorized
    flash[:alert] = 'Vous n\'êtes pas autorisé à effectuer cette action.'
    redirect_back(fallback_location: root_path)
  end
end
