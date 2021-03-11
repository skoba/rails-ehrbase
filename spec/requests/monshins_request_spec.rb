# coding: utf-8
RSpec.describe 'Monshin Management', type: :request do
  describe 'GET index' do
    before(:all) do
      @ehr = Ehr.create!
      @monshin = Monshin.new(ehr_id: @ehr.id,
                             author: "Shinji Kobayashi",
                             height_length: 178.0,
                           height_length_unit: "cm",
                           weight: 60.2,
                           weight_unit: "kg",
                           temperature: 36.2,
                           temperature_unit: "Cel",
                           confounding_factors: "着衣",
                           presenting_problem: "頭痛",
                           story: "3日前から頭痛。激しくなり来院",
                           symptom_sign_name: "頭痛")
#      2.times { Monshin.create(ehr_id: @ehr.id, body: body) }
    end

    it 'requested successfully' do
      get monshins_url(ehr_id: @ehr.id)
      expect(response).to have_http_status(200)
    end
  end
end
