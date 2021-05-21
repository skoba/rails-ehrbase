require 'rails_helper'

RSpec.describe "Rorollers", type: :request do
  describe "GET /diagnoses_lists" do
    it "returns http success" do
      get "/roroller/diagnoses_lists"
      expect(response).to have_http_status(:success)
    end
  end

end
