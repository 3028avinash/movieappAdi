class PlayTimesController < ApplicationController
  before_action :set_play_time, only: %i[ show edit update destroy ]

  # GET /play_times or /play_times.json
  def index
    @play_times = PlayTime.all
  end

  # GET /play_times/1 or /play_times/1.json
  def show
  end

  # GET /play_times/new
  def new
    @play_time = PlayTime.new
  end

  # GET /play_times/1/edit
  def edit
  end

  # POST /play_times or /play_times.json
  def create
    @play_time = PlayTime.new(play_time_params)

    respond_to do |format|
      if @play_time.save
        format.html { redirect_to play_time_url(@play_time), notice: "Play time was successfully created." }
        format.json { render :show, status: :created, location: @play_time }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @play_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /play_times/1 or /play_times/1.json
  def update
    respond_to do |format|
      if @play_time.update(play_time_params)
        format.html { redirect_to play_time_url(@play_time), notice: "Play time was successfully updated." }
        format.json { render :show, status: :ok, location: @play_time }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @play_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /play_times/1 or /play_times/1.json
  def destroy
    @play_time.destroy

    respond_to do |format|
      format.html { redirect_to play_times_url, notice: "Play time was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_play_time
      @play_time = PlayTime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def play_time_params
      params.require(:play_time).permit(:user_id, :episode_id, :time)
    end
end
