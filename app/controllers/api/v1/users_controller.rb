# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    @user = User.new(devise_parameter_sanitizer.sanitize(:sign_up))

    if @user.save
      @user.remember_me = true
      sign_in @user
      render json: {
        token: @user.api_tokens.where(name: ApiToken::APP_NAME).first_or_create.token
      }
    else
      render json: {
        errors: @user.errors,
        error: @user.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end

  private

  def devise_parameter_sanitizer
    @devise_parameter_sanitizer ||= Devise::ParameterSanitizer.new(User, :user, params)
  end
end
