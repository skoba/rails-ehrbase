class Diagnosis < Composition

  class << self
    def search_code(description)
      tc = Base.termserv_connection
      res = tc.get('/codes', description: description)

      JSON.parse(res.body).map do |item|
        { code: item['code'], description: item['description'] }
      end
    end
  end
end

