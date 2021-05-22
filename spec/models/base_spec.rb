RSpec.describe Base do
  it 'should provide a connection to EHRbase server' do
    connection = Base.connection
    expect(connection).not_to be_nil
  end

  it 'should provide a connection to ORCA server' do
    connection = Base.orca_connection
    expect(connection).not_to be_nil
  end

  it 'should provide a connection to Terminology server' do
    connection = Base.termserv_connection
    expect(connection).not_to be_nil
  end
end
