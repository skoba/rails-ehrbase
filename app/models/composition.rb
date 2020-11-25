require 'json'

class Composition
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Base

  attr_reader :id, :version, :system

  attribute :ehr_id, :string
  attribute :body, :string

  validates :ehr_id, presence: true
  validates :body, presence: true

  define_model_callbacks :save, only: :before
  before_save { throw(:abort) if invalid? }

  def save
    res = Base.connection.post("ehr/#{ehr_id}/composition",
                               body,
                               'Content-Type' => 'application/json')
    @id, @system, @version = res.header['ETag'][0][1..-2].split('::')
    res
  end

  def update(params = {})
    @body = params[:body]
    res = Base.connection.put("ehr/#{ehr_id}/composition/#{@id}",
                              body,
                              'Content-Type' => 'application/json',
                              'If-Match' => "#{@id}::#{@system}::#{@version}")
    @id, @system, @version = res.header['ETag'][0][1..-2].split('::')
    res    
  end

  def delete
    Base.connection.delete("ehr/#{ehr_id}/composition/#{@id}::#{@system}::#{@version}")
  end

  class << self
    def create(params = {})
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
