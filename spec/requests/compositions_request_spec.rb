require 'rails_helper'

RSpec.describe "Compositions", type: :request do
  describe 'get #index' do
    xit 'returns a successful response' do
      get '/compositions'
      expect(response).to be_success
    end
  end
end
