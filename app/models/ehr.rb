class Ehr
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Base

  attribute :id

  def save
    res = Base.connection.post('ehr')
    self.id = res_headers['ETag'][1..-2]
  end

  def self.all

  end
end
