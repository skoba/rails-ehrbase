require 'active_model'

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
  end
end
