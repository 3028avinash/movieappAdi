class AppopensController < ApplicationController
  before_action :set_appopen, only: %i[ show edit update destroy ]
  before_action :authorize

  # GET /appopens or /appopens.json
  def index
    @appopens = Appopen.all
  end

  # GET /appopens/1 or /appopens/1.json
  def show
  end

  # GET /appopens/new
  def new
    @appopen = Appopen.new
  end

  # GET /appopens/1/edit
  def edit
  end

  # POST /appopens or /appopens.json
  def create
    @appopen = Appopen.new(appopen_params)

    respond_to do |format|
      if @appopen.save
        format.html { redirect_to appopen_url(@appopen), notice: "Appopen was successfully created." }
        format.json { render :show, status: :created, location: @appopen }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appopen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appopens/1 or /appopens/1.json
  def update
    respond_to do |format|
      if @appopen.update(appopen_params)
        format.html { redirect_to appopen_url(@appopen), notice: "Appopen was successfully updated." }
        format.json { render :show, status: :ok, location: @appopen }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appopen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appopens/1 or /appopens/1.json
  def destroy
    @appopen.destroy

    respond_to do |format|
      format.html { redirect_to appopens_url, notice: "Appopen was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appopen
      @appopen = Appopen.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appopen_params
      params.require(:appopen).permit(:user_id, :source_ip, :location, :version_name, :version_code)
    end
end
