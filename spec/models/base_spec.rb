RSpec.describe Base do
  xit 'should provide a connection to EHRbase server' do
    connection = Base.connection
    expect(connection).not_to be_nil
  end
end
