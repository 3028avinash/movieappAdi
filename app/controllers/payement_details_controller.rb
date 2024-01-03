class PayementDetailsController < ApplicationController
  before_action :set_payement_detail, only: %i[ show edit update destroy ]

  # GET /payement_details or /payement_details.json
  def index
    @payement_details = PayementDetail.all
  end

  # GET /payement_details/1 or /payement_details/1.json
  def show
  end

  # GET /payement_details/new
  def new
    @payement_detail = PayementDetail.new
  end

  # GET /payement_details/1/edit
  def edit
  end

  # POST /payement_details or /payement_details.json
  def create
    @payement_detail = PayementDetail.new(payement_detail_params)

    respond_to do |format|
      if @payement_detail.save
        format.html { redirect_to payement_detail_url(@payement_detail), notice: "Payement detail was successfully created." }
        format.json { render :show, status: :created, location: @payement_detail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payement_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payement_details/1 or /payement_details/1.json
  def update
    respond_to do |format|
      if @payement_detail.update(payement_detail_params)
        format.html { redirect_to payement_detail_url(@payement_detail), notice: "Payement detail was successfully updated." }
        format.json { render :show, status: :ok, location: @payement_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payement_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payement_details/1 or /payement_details/1.json
  def destroy
    @payement_detail.destroy

    respond_to do |format|
      format.html { redirect_to payement_details_url, notice: "Payement detail was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payement_detail
      @payement_detail = PayementDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payement_detail_params
      params.require(:payement_detail).permit(:user_id, :subscription_id, :order_id, :payement_id, :amount)
    end
end
