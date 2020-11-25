RSpec.describe 'Composition Management', type: :request do
  describe 'GET index' do
    let(:person) { FactoryBot.create :person }
    let(:compositions) { FactoryBot.create_list composition: 2 }

    it 'requested successfully' do
      get person_compositions_url(person.id)
      expect(response).to have_http_status(200)
    end
  end
end
