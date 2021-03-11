class Ehr
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Base

  attr_reader :id
  attr_reader :errors

  attribute :id, :string
  
  define_model_callbacks :save, only: :before
  before_save { throw(:abort) if invalid? }

  def initialize(params = {})
    @id = params[:id]
    @errors = ActiveModel::Errors.new(self)
  end

  def save
    unless @id
      res = Base.connection.post('ehr')
      @id = res.headers['ETag'][1..-2]
    end
  end

  def save!
    save
    self
  end

  def compositions
    Compositions.find_all(ehr_id: self.id)
  end

  def person
    Person.find_by(ehr_id: self.id)
  end

  class << self
    def create!(params = {})
      Ehr.new(params).save!
    end

    def all
      Person.all.map do |person|
        Ehr.new(id: person.ehr_id)
      end
    end
    
    def find(id)
      Ehr.new(id: id)
    end
  end
end
