class FavoriteListsController < ApplicationController
  before_action :set_favorite_list, only: %i[ show edit update destroy ]

  # GET /favorite_lists or /favorite_lists.json
  def index
    @favorite_lists = FavoriteList.all
  end

  # GET /favorite_lists/1 or /favorite_lists/1.json
  def show
  end

  # GET /favorite_lists/new
  def new
    @favorite_list = FavoriteList.new
  end

  # GET /favorite_lists/1/edit
  def edit
  end

  # POST /favorite_lists or /favorite_lists.json
  def create
    @favorite_list = FavoriteList.new(favorite_list_params)

    respond_to do |format|
      if @favorite_list.save
        format.html { redirect_to favorite_list_url(@favorite_list), notice: "Favorite list was successfully created." }
        format.json { render :show, status: :created, location: @favorite_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @favorite_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorite_lists/1 or /favorite_lists/1.json
  def update
    respond_to do |format|
      if @favorite_list.update(favorite_list_params)
        format.html { redirect_to favorite_list_url(@favorite_list), notice: "Favorite list was successfully updated." }
        format.json { render :show, status: :ok, location: @favorite_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @favorite_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorite_lists/1 or /favorite_lists/1.json
  def destroy
    @favorite_list.destroy

    respond_to do |format|
      format.html { redirect_to favorite_lists_url, notice: "Favorite list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite_list
      @favorite_list = FavoriteList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_list_params
      params.require(:favorite_list).permit(:user_id, :episode_id)
    end
end
