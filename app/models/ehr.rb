class Ehr
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Base

  attribute :id, :string

  define_model_callbacks :save, only: :before
  before_save { throw(:abort) if invalid? }

  def initalize(params = {})
    self.id = params[:id]
  end

  def save
    unless self.id
      res = Base.connection.post('ehr')
      self.id = res.headers['ETag'][1..-2]
    end
    self
  end

  def compositions
    Compositions.find_all(ehr_id: self.id)
  end

  def person
    Person.find_by(ehr_id: self.id)
  end

  def self.create!(params = {})
    Ehr.new(params).save
  end

  def self.all
    Person.all.map do |person|
      Ehr.new(id: person.ehr_id)
    end
  end

  def self.find(id)
    Ehr.new(id: id)
  end
end
