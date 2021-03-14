RSpec.describe Ehr, type: :model do
  let(:ehr) { Ehr.create! }
  
  it 'should have ehr_id' do
    expect(ehr.id).not_to be_nil
  end

  it 'can register other local id'
end
