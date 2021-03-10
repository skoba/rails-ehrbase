class Person < Actor
  attr_accessor :ehr

  before_create do
    @ehr = Ehr.create!
  end
end
