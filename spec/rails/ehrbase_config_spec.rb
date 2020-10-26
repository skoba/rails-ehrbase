RSpec.describe 'EHRbase configuration' do
  it 'should have scheme' do
    expect(EHRbase.scheme).to eq 'http'
  end

  it 'should have host' do
    expect(EHRbase.host).to eq 'localhost'
  end

  it 'should have port' do
    expect(EHRbase.port).to eq 8080
  end

  it 'should have path_prefix' do
    expect(EHRbase.path_prefix).to eq 'ehrbase/rest/openehr/v1/'
  end

  it 'should have url' do
    expect(EHRbase.url).to eq \
             'http://localhost:8080/ehrbase/rest/openehr/v1/'
  end

  it 'should compose url from scratch' do
    EHRbase.yaml = EHRBASE_CONFIG_WITHOUT_URL
    expect(EHRbase.url).to eq \
           'http://localhost:8080/ehrbase/rest/openehr/v1/'
  end
end

EHRBASE_CONFIG_WITHOUT_URL=<<END
test:
  scheme: http
  host: localhost
  port: 8080
  path_prefix: ehrbase/rest/openehr/v1/
END
