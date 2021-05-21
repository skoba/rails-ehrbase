require 'rails_helper'

RSpec.describe "DiagnosesLists", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/diagnoses_lists/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/diagnoses_lists/show"
      expect(response).to have_http_status(:success)
    end
  end

end
