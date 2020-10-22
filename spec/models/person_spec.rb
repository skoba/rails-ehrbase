require 'httpclient'

RSpec.describe Person, type: :model do
  context 'without external id' do
    it 'should create EHR' do
      person = Person.create
      expect(person.ehr_id).not_to be_nil
    end
  end

  context 'with external id'
end
