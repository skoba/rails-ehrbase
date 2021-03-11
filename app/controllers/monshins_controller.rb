class MonshinsController < ApplicationController
#  before_action :set_monshin, only: [:show, :edit, :update, :destroy]
  
  def index
    @ehr = Ehr.find(params[:ehr_id])
    @monshins = Monshin.find_by_ehr_id(params[:ehr_id])
  end

  def show
    @ehr = Ehr.find(params[:ehr_id])
    @monshin = Monshin.find_by_id(params[:ehr_id], params[:id])
  end

  def edit
    @ehr = Ehr.find(params[:ehr_id])
    @monshin = Monshin.find_by_id(params[:ehr_id], params[:id])
  end

  def new
    @ehr = Ehr.find(params[:ehr_id])
    @monshin = Monshin.new
  end

  def update
    @ehr = Ehr.find(params[:ehr_id])
    @monshin = Monshin.new(monshin_params)
    respond_to do |format|
      if @monshin.update(monshin_params)
        format.html { redirect_to ehr_monshins_path, notice: 'monshin was success
fully updated.' }
        format.json { render :show, status: :ok, location: ehr_monshins_path }
      else
        format.html { render :edit }
        format.json { render json: @monshin.errors, status: :unprocessable_e
ntity }
      end
    end
  end

  private

  def monshin_params
    params.require(:monshin).permit! #(:id, :ehr_id, :system, :version, :author, :height_length, :height_length_unit, :weight, :weight_unit, :temperature, :temperature_unit, :confounding_factors, :presenting_problem, :story, :symptom_sign_name, :start_time)
  end

end
