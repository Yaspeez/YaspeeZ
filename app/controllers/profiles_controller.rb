# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    redirect_to athlete_path(current_user)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)

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

    if @user.save(context: :update)
      redirect_to profile_path(current_user), notice: "Votre profil a été mis à jour avec succès."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :age,
      :avatar,
      :city_id,
      :city_name,
      :nickname,
      :sport_id
    )
  end
end

