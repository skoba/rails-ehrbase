require 'rails_helper'

RSpec.describe 'Ehrs', type: :request do
  describe 'GET #index' do
    it 'should get a response successfully' do
      get ehrs_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET person record by ID' do
    xit 'reads a personal record' do
      create :ehr
      get person_path, params: { }
    end
  end
end
