# coding: utf-8
RSpec.describe Monshin, type: :model do
  let(:ehr) { Ehr.create! }
  let(:monshin) { Monshin.new(ehr_id: ehr.id,
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
                              symptom_sign_name: "頭痛") }
  describe '#create' do
    it 'should post a composition to create a record in EHRbase via REST API' do
      expect(monshin).to be_valid
    end
    
    it 'should save properly' do
      res = monshin.save
      expect(res.status).to eq 200
    end

    it 'should have one EHR' do
      expect(monshin.ehr.id).not_to be_nil
    end
  end

  describe '#read' do
    it 'should get the composition by id from EHRbase via REST API' do
      res = monshin.save
      monshin_id = JSON.parse(res.body)["compositionUid"]
      body = JSON.parse Monshin.find_by_id(ehr.id, monshin_id).body
     
      expect( body['name']['value']).to eq 'monshin.v.0.0.0'
    end

    it 'should get the list of composition by EHR ID from EHRbase via REST API' do
      monshin.save
      expect(Monshin.find_by_ehr_id(ehr.id).size).to be >= 1
    end
  end

  describe '#update' do
    it 'should update the composition by id in EHRbase via REST API' do
      old_version = monshin.save.version
      monshin.update(temperature: 36.8)
      expect(monshin.version).to eq "#{old_version.to_i + 1}"
    end
  end

  describe '#delete' do
    it 'should delete the composition by id in EHRbase via REST API' do
      monshin.save
      res = monshin.delete
      expect(res.status).to eq 204
    end
  end

end

  
