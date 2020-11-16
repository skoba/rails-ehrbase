require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'rm_type' do
    let(:party) { build :party }
    it 'should be "Party"' do
      expect(party.rm_type).to eq 'Party'
    end
  end
end
