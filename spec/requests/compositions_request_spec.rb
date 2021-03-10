RSpec.describe 'Composition Management', type: :request do
  describe 'GET index' do
    let(:ehr) { create :ehr }
    let(:compositions) { create_list composition: 2 }

    it 'requested successfully' do
      get ehr_compositions_url(ehr.id)
      expect(response).to have_http_status(200)
    end
  end
end
