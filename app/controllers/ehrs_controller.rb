class EhrsController < ApplicationController
  def index
    @ehrs = Ehr.all
  end

  def show
    @ehr = Ehr.find(params[:id])
  end

  def new
    @ehr = Ehr.new
  end
end
