# frozen_string_literal: true

module Activities
  class CommentsController < ApplicationController
    before_action :set_comment, only: %i[ update destroy ]

    # POST /comments or /comments.json
    def create
      @comment = @activity.comments.new(comment_params)
      authorize [:activity, @comment]

      @comment.author = current_user

      respond_to do |format|
        if @comment.save
          format.html { redirect_to activity_path(@activity), notice: "Commentaire ajouté avec succès." }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /comments/1 or /comments/1.json
    def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to activity_path(@activity), notice: "Commentaire modifié avec succès." }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /comments/1 or /comments/1.json
    def destroy
      @comment.destroy

      respond_to do |format|
        format.html { redirect_to activity_path(@activity), notice: "Commentaire supprimé avec succès." }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      authorize [:activity, @comment]
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
end
