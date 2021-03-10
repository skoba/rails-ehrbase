class Monshin < Composition
  attr_accessor :author, :height_length, :height_length_unit
  attr_accessor :weight, :weight_unit
  attr_accessor :temperature, :temperature_unit
  attr_accessor :confounding_factors, :presenting_problem
  attr_accessor :story, :symptom_sign_name

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
    super(ehr_id: params[:ehr_id], body: body)
  end
  
  def connection
    @con ||= HTTPClient.new(base_url: "#{EHRbase.scheme}://#{EHRbase.host}:#{EHRbase.port}/ehrbase/rest/ecis/v1/",
                            user: EHRbase.username,
                            password: EHRbase.password)
  end
  
  def save
    res = connection.post("composition/", {query: {'format' => 'FLAT', 'templateId' => 'monshin.v.0.0.0', 'ehrId' => @ehr_id}, body: body, header: {'Content-Type' => 'application/json'}})

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
    res = connection.put("composition/#{@id}", {query: {'format' => 'FLAT', 'templateId' => 'monshin.v.0.0.0', 'ehrId' => ehr_id}, body: body, header: {'Content-Type' => 'application/json'}})
    @version = JSON.parse(res.body)['meta']['href']['url'].split('::')[1]
    res
  end

  def body
    current_date_time ||= Time.now.iso8601
    body = <<"END"
{
  "monshin.v.0.0.0/context/start_time": "#{current_date_time}",
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
    def create(params)
      self.new(params).save
    end

    def create!(params)
      self.new(params).save!
    end
  end
end
