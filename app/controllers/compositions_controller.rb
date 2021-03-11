class CompositionsController < ApplicationController
  def index(params)
    @compositions = Composition.find_by_ehr_id(params[:ehr_id])
  end
end
