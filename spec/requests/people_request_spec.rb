require 'rails_helper'

RSpec.describe 'People Management', type: :request do
  let(:people) { FactoryBot.create_list people: 2 }

  it 'requested successfull' do
    get people_url
    expect(response).to have_http_status(200)
  end

  xit 'post new patient' do
    
  end
end
