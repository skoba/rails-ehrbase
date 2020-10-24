RSpec.describe Person, type: :model do
  it 'should not generate ehr_id by new' do
    person = Person.new
    expect(person.ehr_id).to be_nil
  end

  it 'should have ehr_id before it create' do
    person = Person.create!
    expect(person.ehr_id).not_to be_nil
  end

  context 'without external id' do
    it 'should create EHR' do
      person = Person.create!
      expect(person.ehr_id).not_to be_nil
    end
  end

  context 'with external id'

end
