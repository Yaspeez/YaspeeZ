# frozen_string_literal: true

module Activities
  module Comments
    class ReportsController < ApplicationController
      before_action :set_comment, only: %i[ create ]

      def create
        @comment.reported_at = DateTime.now
        @comment.reported_by = current_user

        if @comment.save
          User.admins.each do |admin|
            # TODO: Change to deliver_later
            ReportActivityCommentNotification.with(activity: @activity).deliver(admin)
          end
          redirect_to activity_path(@activity), notice: "Signalement effectué avec succès."
        else
          redirect_to activity_path(@activity), alert: "Une erreur s'est produite lors de votre signalement. Veuillez réessayer."
        end
      end

      private

      def set_comment
        @comment = Comment.find(params[:comment_id])
      end
    end
  end
end
