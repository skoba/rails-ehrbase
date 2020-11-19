RSpec.describe Person, type: :model do
  it 'should not generate ehr_id by new' do
    person = build :person
    expect(person.ehr_id).to be_nil
  end

  it 'should have ehr_id before it create' do
    person = create :person
    expect(person.ehr_id).not_to be_nil
  end

  context 'without external id' do
    it 'should create EHR' do
      person = create :person
      expect(person.ehr_id).not_to be_nil
    end
  end

  context 'with external id' do
    
  end
end
