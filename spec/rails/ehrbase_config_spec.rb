require 'rails_helper'

RSpec.describe 'configuration' do
  it 'should have scheme' do
    expect(EHRbase['scheme']).to eq 'http'
  end

  it 'should have host address' do
    expect(EHRbase['host']).to eq 'localhost'
  end

  it 'should have port' do
    expect(EHRbase['port']).to eq 8080
  end

  it 'should have path' do
    expect(EHRbase['path']).to eq 'ehrbase/rest/openehr/v1'
  end

  it 'should compose url' do
    expect(EHRbase['url']).to eq 'http://localhost:8080/ehrbase/rest/openehr/v1/'
  end

  it 'should show auth pattern if any' do
    expect(EHRbase['auth']).to eq 'basic'
  end
end
