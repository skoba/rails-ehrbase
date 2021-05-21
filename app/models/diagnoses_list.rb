# coding: utf-8
class DiagnosesList < Composition
  attr_accessor :author
  attr_accessor :start_date, :end_date  
  attr_accessor :diagnsis_name, :diagnosis_code

  attribute :start_date, :date
  attribute :end_date, :date
  attribute :author, :string
  attribute :diagnosis_name, :string
  attribute :diagnosis_code, :string

  def initialize(params)
    params.each do |key, value|
      eval "@#{key} = value"
    end
  end
  
  def connection
    @con ||= HTTPClient.new(base_url: "#{EHRbase.scheme}://#{EHRbase.host}:#{EHRbase.port}/ehrbase/rest/ecis/v1/",
                            user: EHRbase.username,
                            password: EHRbase.password)
  end

  def orca_connetion
    @con ||= HTTPClient.new
  end

  def save
    res = self.connection.post("composition/", {query: {'format' => 'FLAT', 'templateId' => 'diagnosis_list', 'ehrId' => @ehr_id}, body: body, header: {'Content-Type' => 'application/json'}})
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
    "ctx/language": "en",
    "ctx/territory": "US",
    "ctx/composer_name": "小林慎治",
    "ctx/id_namespace": "Wako hospital",
    "ctx/id_scheme": "Wako hospital",
    "ctx/participation_name": "小林慎治",
    "ctx/participation_function": "requester",
    "ctx/participation_mode": "tele-communication", 
    "ctx/participation_id": "12345",
    "ctx/health_care_facility|name": "Wako Hospital",
    "ctx/health_care_facility|id": "9999",
    "diagnosis_list/problem_list/problem_diagnosis/problem_diagnosis_name|code": "#{disease_code}",
    "diagnosis_list/problem_list/problem_diagnosis/problem_diagnosis_name|value": "#{disease_name}",
    "diagnosis_list/problem_list/problem_diagnosis/problem_diagnosis_name|terminology": "Shoubyoumei Master",
    "diagnosis_list/problem_list/problem_diagnosis/date_time_of_onset": "#{start_date}",
    "diagnosis_list/problem_list/problem_diagnosis/date_time_of_resolution": "#{end_date}",
    "diagnosis_list/problem_list/problem_diagnosis/last_updated": "#{Date.today.iso8601}"
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
      aql = "select c from EHR [ehr_id/value='#{ehr_id}'] CONTAINS COMPOSITION c[openEHR-EHR-COMPOSITION.problem_list.v2] where c/archetype_details/template_id/value = 'diagnosis_list'"
      query = { 'q' => aql }
      res = Base.connection.get('query/aql', query)
      p res.body
      JSON.parse(res.body)['rows'].map do |row|
        DiagnosisList.new(ehr_id: row[0],
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
    
    def find_by_id(ehr_id, diagnoses_list_id)
      res = Base.connection.get("ehr/#{ehr_id}/composition/#{monshin_id}")
      row = JSON.parse(res.body)

      DiagnosisList.new(ehr_id: ehr_id,
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
      aql = "select c from COMPOSITION c[openEHR-EHR-COMPOSITION.problem_list.v2] where c/archetype_details/template_id/value = 'diagnosis_list'"
      query = { 'q' => aql }
      res = Base.connection.get('query/aql', query)
      JSON.parse(res.body)['rows'].map do |row|
        DiagnosesList.new(ehr_id: @ehr_id,
                    id: row[0]['uid']['value'].split('::')[0],
                    system: row[0]['uid']['value'].split('::')[1],
                    version: row[0]['uid']['value'].split('::')[2],
                          diagnosis_name: row[0]['content'][0]['items'][0]['data']['items'][0]['value']['value'],
                          diagnosis_code: row[0]['content'][0]['items'][0]['data']['items'][0]['value']['defining_code']['code_string'],
                          start_date: row[0]['content'][0]['items'][0]['data']['items'][2]['value']['value'],
                          end_date: row[0]['content'][0]['items'][0]['data']['items'][1]['value']['value']
                   )
      end
    end
  end

end
