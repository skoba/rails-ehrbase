require 'rails_helper'

RSpec.describe 'Composition Management', type: :request do
  describe 'GET index' do
    let(:compositions) { FactoryBot.create_list composition: 2 }

    it 'requested successfully' do
      get :compositions_url
      expect(response.status).to eq 200
    end
  end
end
