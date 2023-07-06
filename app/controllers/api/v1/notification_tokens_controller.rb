# frozen_string_literal: true

class Api::V1::NotificationTokensController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  skip_after_action :verify_authorized
  before_action :authenticate_api_token!

  def create
    current_user.notification_tokens.find_or_create_by(token: params[:token], platform: params[:platform])
  end

  private

  def authenticate_api_token!
    token = request.headers.fetch("Authorization", "").split(" ").last
    api_token = ApiToken.find_by(token:)
    if api_token.present?
      user = api_token.user
      sign_in user, store: false
    else
      head :unauthorized
    end
  end
end
