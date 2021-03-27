class Monshin < Composition
  attr_accessor :author, :height_length, :height_length_unit
  attr_accessor :weight, :weight_unit
  attr_accessor :temperature, :temperature_unit
  attr_accessor :confounding_factors, :presenting_problem
  attr_accessor :story, :symptom_sign_name
  attr_accessor :start_time

  attribute :start_time, :datetime
  attribute :author, :string
  attribute :height_length, :decimal
  attribute :height_length_unit, :string
  attribute :weight, :decimal
  attribute :weight_unit, :string
  attribute :temperature, :decimal
  attribute :temperature_unit, :string
  attribute :confounding_factors, :string
  attribute :presenting_problem, :string
  attribute :story, :string
  attribute :symptom_sign_name, :string

  def initialize(params)
    params.each do |key, value|
      eval "@#{key} = value"
    end
    super(params)
  end
  
  def connection
    @con ||= HTTPClient.new(base_url: "#{EHRbase.scheme}://#{EHRbase.host}:#{EHRbase.port}/ehrbase/rest/ecis/v1/",
                            user: EHRbase.username,
                            password: EHRbase.password)
  end
  
  def save
    res = self.connection.post("composition/", {query: {'format' => 'FLAT', 'templateId' => 'monshin.v.0.0.0', 'ehrId' => @ehr_id}, body: body, header: {'Content-Type' => 'application/json'}})
p res.body
    @id, @version = JSON.parse(res.body)['compositionUid'].split('::')
    res
  end

  def save!
    save
    self
  end

  def update(params = {})
    params.keys.each do |key|
      eval "@#{key} = params[key]"
    end
    res = self.connection.put("composition/#{@id}", {query: {'format' => 'FLAT', 'templateId' => 'monshin.v.0.0.0', 'ehrId' => ehr_id}, body: body, header: {'Content-Type' => 'application/json'}})
p JSON.parse(res.body)['meta']['href']
    @version = JSON.parse(res.body)['meta']['href']['url'].split('::')[1]
    res
  end

  def body
    @start_time = Time.now.iso8601
    body = <<"END"
{
  "monshin.v.0.0.0/context/start_time": "#{@start_time}",
  "monshin.v.0.0.0/context/setting|code": "228",
  "monshin.v.0.0.0/context/setting|value": "primary medical care",
  "monshin.v.0.0.0/context/setting|terminology": "openehr",
  "monshin.v.0.0.0/category|code": "433",
  "monshin.v.0.0.0/category|value": "event",
  "monshin.v.0.0.0/category|terminology": "openehr",
  "monshin.v.0.0.0/language|code": "en",
  "monshin.v.0.0.0/language|terminology": "ISO_639-1",
  "monshin.v.0.0.0/territory|code": "JP",
  "monshin.v.0.0.0/territory|terminology": "ISO_3166-1",
  "monshin.v.0.0.0/composer|name": "#{author}",
  "monshin.v.0.0.0/height_length/any_event:0/height_length|magnitude": #{@height_length},
  "monshin.v.0.0.0/height_length/any_event:0/height_length|unit": "#{@height_length_unit}",
  "monshin.v.0.0.0/height_length/language|code": "en",
  "monshin.v.0.0.0/height_length/language|terminology": "ISO_639-1",
  "monshin.v.0.0.0/height_length/any_event:0/time": "2021-03-08T06:34:49.636Z",
  "monshin.v.0.0.0/body_weight/any_event:0/weight|magnitude": #{@weight},
  "monshin.v.0.0.0/body_weight/language|code": "en",
  "monshin.v.0.0.0/body_weight/language|terminology": "ISO_639-1",
  "monshin.v.0.0.0/body_weight/any_event:0/time": "2021-03-08T06:34:52.404Z",
  "monshin.v.0.0.0/body_weight/any_event:0/weight|unit": "#{@weight_unit}",
  "monshin.v.0.0.0/body_temperature/any_event:0/temperature|magnitude": #{@temperature},
  "monshin.v.0.0.0/body_temperature/language|code": "en",
  "monshin.v.0.0.0/body_temperature/language|terminology": "ISO_639-1",
  "monshin.v.0.0.0/body_temperature/any_event:0/time": "2021-03-08T06:34:57.497Z",
  "monshin.v.0.0.0/body_temperature/any_event:0/temperature|unit": "#{@temperature_unit}",
  "monshin.v.0.0.0/body_temperature/any_event:0/confounding_factors:0": "#{@confounding_factors}",
  "monshin.v.0.0.0/reason_for_encounter/presenting_problem:0": "#{@presenting_problem}",
  "monshin.v.0.0.0/reason_for_encounter/language|code": "en",
  "monshin.v.0.0.0/reason_for_encounter/language|terminology": "ISO_639-1",
  "monshin.v.0.0.0/story_history/any_event:0/story:0": "#{@story}",
  "monshin.v.0.0.0/story_history/language|code": "en",
  "monshin.v.0.0.0/story_history/language|terminology": "ISO_639-1",
  "monshin.v.0.0.0/story_history/any_event:0/time": "2021-03-08T06:35:47.478Z",
  "monshin.v.0.0.0/story_history/any_event:0/symptom_sign/symptom_sign_name": "#{@symptom_sign_name}"
}
END
  end

  class << self
    def connection
      @con ||= HTTPClient.new(base_url: "#{EHRbase.scheme}://#{EHRbase.host}:#{EHRbase.port}/ehrbase/rest/ecis/v1/",
                            user: EHRbase.username,
                            password: EHRbase.password)
    end

    def find_by_ehr_id(ehr_id)
      aql = "select c from EHR [ehr_id/value='#{ehr_id}'] CONTAINS COMPOSITION c[openEHR-EHR-COMPOSITION.Encounter.v1] where c/archetype_details/template_id/value = 'monshin.v.0.0.0'"
      query = { 'q' => aql }
      res = Base.connection.get('query/aql', query)
      JSON.parse(res.body)['rows'].map do |row|
        Monshin.new(ehr_id: row[0],
                    start_time: row[0]['context']['start_time']['value'],
                    name: row[0]['name']['value'],
                    id: row[0]['uid']['value'].split('::')[0],
                    system: row[0]['uid']['value'].split('::')[1],
                    version: row[0]['uid']['value'].split('::')[2],
                    story: row[0]['content'][0]['data']['events'][0]['data']['items'][0]['value']['value'],
                    symptom_sign_name: row[0]['content'][0]['data']['events'][0]['data']['items'][1]['items'][0]['value']['value'],
                    height_length: row[0]['content'][1]['data']['events'][0]['data']['items'][0]['value']['magnitude'],
                    height_length_unit: row[0]['content'][1]['data']['events'][0]['data']['items'][0]['value']['unit'],
                    weight: row[0]['content'][2]['data']['events'][0]['data']['items'][0]['value']['magnitude'],
                    weight_unit: row[0]['content'][2]['data']['events'][0]['data']['items'][0]['value']['unit'],
                    temperature: row[0]['content'][3]['data']['events'][0]['data']['items'][0]['value']['magnitude'],
                    temperature_unit: row[0]['content'][3]['data']['events'][0]['data']['items'][0]['value']['unit'],
                    confounding_factors: row[0]['content'][3]['data']['events'][0]['state']['items'][0]['value']['value'],
                    presenting_problem: row[0]['content'][4]['data']['items'][0]['value']['value']
                   )
      end
    end
    
    def find_by_id(ehr_id, monshin_id)
      res = Base.connection.get("ehr/#{ehr_id}/composition/#{monshin_id}")
      row = JSON.parse(res.body)

      Monshin.new(ehr_id: ehr_id,
                  start_time: row['context']['start_time']['value'],
                  name: row['name']['value'],
                  id: row['uid']['value'].split('::')[0],
                  system: row['uid']['value'].split('::')[1],
                  version: row['uid']['value'].split('::')[2],
                  story: row['content'][0]['data']['events'][0]['data']['items'][0]['value']['value'],
                  symptom_sign_name: row['content'][0]['data']['events'][0]['data']['items'][1]['items'][0]['value']['value'],
                  height_length: row['content'][1]['data']['events'][0]['data']['items'][0]['value']['magnitude'],
                  height_length_unit: row['content'][1]['data']['events'][0]['data']['items'][0]['value']['unit'],
                  weight: row['content'][2]['data']['events'][0]['data']['items'][0]['value']['magnitude'],
                  weight_unit: row['content'][2]['data']['events'][0]['data']['items'][0]['value']['unit'],
                  temperature: row['content'][3]['data']['events'][0]['data']['items'][0]['value']['magnitude'],
                  temperature_unit: row['content'][3]['data']['events'][0]['data']['items'][0]['value']['unit'],
                  confounding_factors: row['content'][3]['data']['events'][0]['state']['items'][0]['value']['value'],
                  presenting_problem: row['content'][4]['data']['items'][0]['value']['value']
                 )
    end

    def create(params)
      self.new(params).save
    end

    def create!(params)
      self.new(params).save!
    end

    def all
      aql = "select c from COMPOSITION c[openEHR-EHR-COMPOSITION.Encounter.v1] where c/archetype_details/template_id/value = 'monshin.v.0.0.0'"
      query = { 'q' => aql }
      res = Base.connection.get('query/aql', query)
      JSON.parse(res.body)['rows'].map do |row|
        Monshin.new(ehr_id: row[0],
                    start_time: row[0]['context']['start_time']['value'],
                    name: row[0]['name']['value'],
                    id: row[0]['uid']['value'].split('::')[0],
                    system: row[0]['uid']['value'].split('::')[1],
                    version: row[0]['uid']['value'].split('::')[2],
                    story: row[0]['content'][0]['data']['events'][0]['data']['items'][0]['value']['value'],
                    symptom_sign_name: row[0]['content'][0]['data']['events'][0]['data']['items'][1]['items'][0]['value']['value'],
                    height_length: row[0]['content'][1]['data']['events'][0]['data']['items'][0]['value']['magnitude'],
                    height_length_unit: row[0]['content'][1]['data']['events'][0]['data']['items'][0]['value']['unit'],
                    weight: row[0]['content'][2]['data']['events'][0]['data']['items'][0]['value']['magnitude'],
                    weight_unit: row[0]['content'][2]['data']['events'][0]['data']['items'][0]['value']['unit'],
                    temperature: row[0]['content'][3]['data']['events'][0]['data']['items'][0]['value']['magnitude'],
                    temperature_unit: row[0]['content'][3]['data']['events'][0]['data']['items'][0]['value']['unit'],
                    confounding_factors: row[0]['content'][3]['data']['events'][0]['state']['items'][0]['value']['value'],
                    presenting_problem: row[0]['content'][4]['data']['items'][0]['value']['value']
                   )
      end
    end
  end

end
