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

    results = Geocoder.search([@user.postal_code, @user.city].join(" "))

    if results.any?
      most_accurate_result = results.first

      @user.latitude = most_accurate_result.latitude
      @user.longitude = most_accurate_result.longitude
    end

    @user.onboarded = true
    @user.postal_code = City.find(params[:user][:city_id]).code_postal

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
