class EpisodesController < ApplicationController
  before_action :set_episode, only: %i[ show edit update destroy ]
  before_action :authorize

  # GET /episodes or /episodes.json
  def index
    # @episodes = Episode.all
    if params[:search]
      @episodes = Episode.search(params[:search]).order('created_at desc')      
    # elsif params[:uid]
    #   user = User.find(params[:uid].to_i)
    #   @episodes = user.episodes.order("created_at desc")      
    else
      #@episodes = Episode.where("created_at >= ?", Date.today).order('created_at desc')
      @episodes = Episode.all.order('created_at desc')
    end
    # .paginate(:page => params[:page], :per_page => PER_PAGE)
  end

  # GET /episodes/1 or /episodes/1.json
  def show
  end

  # GET /episodes/new
  def new
    @episode = Episode.new
  end

  # GET /episodes/1/edit
  def edit
  end

  # POST /episodes or /episodes.json
  def create
    @episode = Episode.new(episode_params)
    respond_to do |format|
      if @episode.file.attached?
        @episode.url ="https://appnine.netdemo.in" + Rails.application.routes.url_helpers.rails_blob_path(@episode.file, only_path: true)
      end
      if @episode.save
        format.html { redirect_to episode_url(@episode), notice: "Episode was successfully created." }
        format.json { render :show, status: :created, location: @episode }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /episodes/1 or /episodes/1.json
  def update
    respond_to do |format|
      if @episode.file.attached?
        @episode.url ="https://appnine.netdemo.in" + Rails.application.routes.url_helpers.rails_blob_path(@episode.file, only_path: true)
      end
      if @episode.update(episode_params)
        format.html { redirect_to episode_url(@episode), notice: "Episode was successfully updated." }
        format.json { render :show, status: :ok, location: @episode }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /episodes/1 or /episodes/1.json
  def destroy
    @episode.destroy

    respond_to do |format|
      format.html { redirect_to episodes_url, notice: "Episode was successfully destroyed." }
      format.json { head :no_Episode }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def episode_params
      params.require(:episode).permit(:content_id, :season, :url, :thumbnail, :title, :runtime, :cast, :director, :story, :vip_status, :status, :file)
    end
end
