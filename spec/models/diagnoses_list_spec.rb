RSpec.describe DiagnosesList, type: :model do
  describe 'communicatin with term server' do
    it 'should get term form server'
  end

  describe 'communiaion with EHRbase' do
    it 'can register diagnosis' do
      diangosis_list = build :diagnosis_list
      expect { diagnosis_list.send_orca }.not_to raise_error
    end
  end

  describe 'communicaiton with ORCA' do
    
  end
end
