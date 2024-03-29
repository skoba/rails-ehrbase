# coding: utf-8
class DiagnosesListsController < ApplicationController
  before_action :set_diagnoses_list, only: [:show, :edit, :update, :destroy]
  def set_diagnoses_list
    @ehr = Ehr.find(params[:ehr_id])
    @diagnoses_list = DiagnosesList.find_by_id(params[:ehr_id], params[:id])
  end

  def index
    @ehr = Ehr.find(params[:ehr_id])
    @diagnoses_lists = DiagnosesList.find_by_ehr_id(@ehr.id)
  end

  def show

  end

  def edit
  end

  def new
    @ehr = Ehr.find(params[:ehr_id])
    @diagnoses_list = DiagnosesList.new(params)
  end

  def create
    params[:author] = 'テスト医師'
    params[:start_date] = Time.new.iso8601
    params[:diagnosis_terminologyo]='Shoubyoumei master'
    @diagnoses_list = DiagnosesList.new(params)
    @diagnoses_lsit.save
    res = @diagnoses_list.save_to_orca

    redirect_to ehr_diagnoses_lists_path
  end

  def update
    @ehr = Ehr.find(params[:ehr_id])
    @diagnoses_list = DiagnosesList.new(diagnoses_list_params)
    respond_to do |format|
      if @diagnoses_list.update(diagnoses_list_params)
        format.html { redirect_to ehr_diagnoses_lists_path, notice: 'Diagnoses List was success
fully updated.' }
        format.json { render :show, status: :ok, location: ehr_diagnoses_list_path }
      else
        format.html { render :edit }
        format.json { render json: @diagnosis_list.errors, status: :unprocessable_e
ntity }
      end
    end
  end

  private

  def diagnoses_list_params
    params.require(:diagnoses_list).permit! #(:id, :ehr_id, :system, :version, :author, :height_length, :height_length_unit, :weight, :weight_unit, :temperature, :temperature_unit, :confounding_factors, :presenting_problem, :story, :symptom_sign_name, :start_time) 
  end
end
