class Person < Actor
  attr_accessor :ehr

  before_create do
    self.ehr = Ehr.create! if @ehr.nil?
    self.ehr_id = @ehr.id
  end

  def rm_type
    'Person'
  end
end
