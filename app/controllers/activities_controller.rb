class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]

  # GET /activities or /activities.json
  def index
    if params[:distance].present?
      @distance = params[:distance].to_i
      @distance = [Activity::MINIMUM_DISTANCE_IN_KM, @distance].max
      @distance = [@distance, Activity::MAXIMUM_DISTANCE_IN_KM].min
    else
      @distance = 10
    end
    @sport = Sport.find(params[:sport_id]) if params[:sport_id].present?
    @handisport = params[:handisport].eql?("1")

    activities = Activity.future.order(starts_at: :asc).near([current_user.latitude, current_user.longitude], @distance, units: :km)
    activities = activities.where(sport: @sport) if @sport.present?
    activities = activities.handisports if @handisport

    @pagy, @activities = pagy(activities)

    authorize @activities
  end

  # GET /activities/1 or /activities/1.json
  def show
    @participants = @activity.participants
    @comments = @activity.comments
    @new_comment = Comment.new(activity: @activity)
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    authorize @activity

    if params[:sport_id].present?
      @activity.sport = Sport.find(params[:sport_id])
    end
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities or /activities.json
  def create
    @activity = current_user.organized_activities.new(activity_params)
    authorize @activity

    @activity.calculate_coordinates
    @activity.participants.new(user: current_user)

    respond_to do |format|
      if @activity.save
        # TODO: Notify prospective participants
        format.html { redirect_to activity_url(@activity), notice: "L'activité a été créée avec succès !" }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1 or /activities/1.json
  def update
    @activity.assign_attributes(activity_params)
    @activity.calculate_coordinates

    respond_to do |format|
      if @activity.save
        format.html { redirect_to activity_url(@activity), notice: "L'activité a été mise à jour avec succès !" }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1 or /activities/1.json
  def destroy
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url, notice: "L'activité a été supprimée avec succès." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    @activity = Activity.find(params[:id])
    authorize @activity
  end

  # Only allow a list of trusted parameters through.
  def activity_params
    params.require(:activity).permit(
      :address,
      :city_id,
      :city_name,
      :description,
      :duration_in_minutes,
      :gender,
      :handisport,
      :level,
      :maximum_participants_number,
      :participants_count,
      :per_participant_price,
      :starts_at,
      :sport_id,
    )
  end
end
