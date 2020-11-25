require 'rails_helper'

RSpec.describe "People", type: :request do
  describe 'GET #index' do
    it 'should get a response successfully' do
      get people_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET person record by ID' do
    it 'reads a personal record' do
      create :person
      get person_path, params: {
            
          }
    end
  end
end
