RSpec.describe Base do
  it 'should provide a connection to EHRbase server' do
    connection = Base.connection
    expect(connection).not_to be_nil
  end
end
