# frozen_string_literal: true

class OnboardingsController < ApplicationController
  skip_before_action :redirect_unonboarded_users

  def show
    @user = current_user
    authorize(:onboarding, :show?)
  end

  def create
    authorize(:onboarding, :create?)

    @user = current_user
    @user.assign_attributes(onboarding_params)

    if @user.city.present?
      @user.postal_code = @user.city.code_postal
      @user.latitude = @user.city.latitude
      @user.longitude = @user.city.longitude
    else
      results = Geocoder.search(@user.city)

      if results.any?
        most_accurate_result = results.first

        @user.latitude = most_accurate_result.latitude
        @user.longitude = most_accurate_result.longitude
      end
    end

    @user.onboarded = true

    if @user.save(context: :update)
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def onboarding_params
    params.require(:user).permit(
      :age,
      :city_name,
      :city_id,
      :avatar,
      :nickname,
      :postal_code,
      :sport_id,
    )
  end
end
