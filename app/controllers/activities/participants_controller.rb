# frozen_string_literal: true

module Activities
  class ParticipantsController < ApplicationController
    def index
      @participants = @activity.participants
      authorize [:activity, @participants]
    end

    def create
      @participation = @activity.participants.new(
        user: current_user,
      )
      authorize [:activity, @participation]

      if @participation.save
        redirect_to @activity, notice: "Vous êtes inscrit avec succès à cette activité !"
      else
        redirect_to @activity, alert: "Une erreur s'est produite lors de votre inscription à cette activité."
      end
    end

    def destroy
      @participation = @activity.participants.find_by(user: current_user)
      authorize [:activity, @participation]

      if @participation.destroy
        redirect_to @activity, notice: "Vous vous êtes désinscrit avec succès de cette activité."
      else
        redirect_to @activity, alert: "Une erreur s'est produite lors de votre désinscription à cette activité."
      end
    end
  end
end
