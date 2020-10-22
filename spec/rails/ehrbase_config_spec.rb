RSpec.describe 'EHRbase configuration' do
  it 'should have scheme'
  it 'should have host'
  it 'should have port'
  it 'should have path'

  it 'should have url' do
    expect(EHRbase['url']).to eq \
             'http://localhost:8080/ehrbase/rest/openehr/v1/'
  end
end
