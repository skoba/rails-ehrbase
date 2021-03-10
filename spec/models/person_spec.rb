RSpec.describe Person, type: :model do
  let(:person) { Person.create!(name: 'KOBAYASHI Shinji') }
  
  it 'should not generate ehr_id by new' do
    person = Person.new(name: 'Other Name')
    expect(person.ehr_id).to be_nil
  end

  it 'should have ehr_id after it created' do
    expect(person.ehr_id).not_to be_nil
  end

  it 'should have one ehr' do
    expect(person.ehr).not_to be_nil
  end

  context 'without external id' do
    it 'should create EHR' do
      expect(person.ehr_id).not_to be_nil
    end
  end

  context 'with external id' do

  end
end
