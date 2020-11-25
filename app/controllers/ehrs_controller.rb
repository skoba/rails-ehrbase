class EhrsController < ApplicationController
  def index
    @ehrs = Ehr.all
  end

  def new
    @ehr = Ehr.new
  end
end
