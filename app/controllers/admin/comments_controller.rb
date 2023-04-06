module Admin
  class CommentsController < ApplicationController
    before_action :set_comment, only: %i[ destroy ]

    def index
      @reported_comments = Comment.reported
    end

    def destroy
      if @comment.destroy
        redirect_to admin_comments_path, notice: "Commentaire supprimé avec succès."
      else
        redirect_to admin_comments_path, alert: "Une erreur s'est produite lors de la suppression du commentaire. Veuillez réessayer."
      end
    end

    private

    def set_comment
      @comment = Comment.find(params[:id])
    end
  end
end
