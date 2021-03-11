RSpec.describe 'Composition Management', type: :request do
  describe 'GET index' do
    before(:all) do
      @ehr = Ehr.create!
      body = File.read(
        Rails.root.join('spec',
                        'factories',
                        'composition_sample_body.json'))
      2.times { Composition.create!(ehr_id: @ehr.id, body: body) }
    end

    it 'requested successfully' do
      get ehr_compositions_url(ehr_id: @ehr.id)
      expect(response).to have_http_status(200)
    end
  end
end
