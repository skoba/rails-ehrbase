require 'active_model'
require 'httpclient'

class Composition
  include ActiveModel::Model
  include ActiveModel::Attributes
  
  attribute :ehr_id, :string
  attribute :body, :string

  validates :ehr_id, presence: true
  validates :body, presence: true

  define_model_callbacks :save, only: :before
  before_save { throw(:abort) if invalid? }

  def save
    ehrbaseclient = HTTPClient.new(base_url: EHRbase['url'], user: 'ehrbase', password: 'SuperSecretPassword')
    ehrbaseclient.post("ehr/#{ehr_id}/composition", body,  'Content-Type' => 'application/json')
  end

  def self.create(params={})
    composition = self.new(ehr_id: params[:ehr_id], body: params[:body])
    composition.save
  end
end
