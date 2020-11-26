class Person < Actor
  attr_accessor :ehr

  before_create do
    @ehr = Ehr.create!
    self.ehr_id = @ehr.id
  end
end
