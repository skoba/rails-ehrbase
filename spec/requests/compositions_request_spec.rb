RSpec.describe 'Composition Management', type: :request do
  describe 'GET index' do
    let(:compositions) { FactoryBot.create_list composition: 2 }

    xit 'requested successfully' do
      get :compositions_url
      expect(response).to have_http_status(200)
    end
  end
end
