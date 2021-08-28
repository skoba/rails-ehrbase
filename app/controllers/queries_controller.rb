class QueriesController < ApplicationController
  def index
    @results = Query.get(queries_params[:aql])
  end

  protected

  def queries_params
    params.permit(:aql) #(:id, :ehr_id, :system, :version, :
  end
end
