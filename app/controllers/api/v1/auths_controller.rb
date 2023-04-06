# frozen_string_literal: true

class Api::V1::AuthsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.valid_password?(params[:password])
      @user.remember_me = true
      sign_in @user
      render json: { token: @user.api_tokens.where(name: ApiToken::APP_NAME).first_or_create.token }
    else
      render json: { error: "Email et/ou mot de passe incorrect(s)."  }, status: :unauthorized
    end
  end
end
