require 'json'

class Query
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Base

  class << self
    def get(aql)
      response = Base.ehrbase_connection.get('query/aql', query: {'q' => aql })
      JSON.parse response.body
    end
  end
end
