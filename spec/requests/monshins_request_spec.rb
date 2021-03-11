RSpec.describe 'Monshin Management', type: :request do
  describe 'GET index' do
    let(:ehr) { create :ehr }
    let(:monshins) { create_list monshin: 2}

    xit 'requested successfully' do
      get ehr_compositions_url(ehr.id)
      expect(response).to have_http_status(200)
    end
  end
end
