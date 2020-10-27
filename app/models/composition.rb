require 'active_model'
require 'httpclient'
require 'json'
require_relative './base'

class Composition
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Base

  attribute :ehr_id, :string
  attribute :body, :string

  validates :ehr_id, presence: true
  validates :body, presence: true

  define_model_callbacks :save, only: :before
  before_save { throw(:abort) if invalid? }

  def save
    Base.connection.post("ehr/#{ehr_id}/composition", body,  'Content-Type' => 'application/json')
  end

  class << self
    def reate(params={})
      composition = self.new(ehr_id: params[:ehr_id], body: params[:body])
      composition.save
    end
    
    def find_by_id(ehr_id, composition_id)
      res = Base.connection.get("ehr/#{ehr_id}/composition/#{composition_id}")
      Composition.new(ehr_id: ehr_id, body: res.body)
    end
    
    def find_by_ehr_id(ehr_id)
      aql =  "select e/ehr_id/value as ehrId, c/context/start_time/value as start_time, c/name/value as name, c/uid/value as uid from EHR e [ehr_id/value='#{ehr_id}']contains COMPOSITION c"
      query = { 'q' => aql }
      res = Base.connection.get('query/aql', query)
      JSON.parse(res.body)
    end
  end
end