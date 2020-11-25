RSpec.describe Ehr, type: :model do
  it 'should not generate ehr_id by new' do
    ehr = build :ehr
    expect(ehr).to be_nil
  end

  it 'should have ehr_id before it create' do
    ehr = create :ehr
    expect(ehr.id).not_to be_nil
  end
end
