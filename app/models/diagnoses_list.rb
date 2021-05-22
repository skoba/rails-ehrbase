# coding: utf-8
class DiagnosesList < Composition
  attr_accessor :author
  attr_accessor :start_date, :end_date  
  attr_accessor :diagnosis_name, :diagnosis_code, :diagnosis_terminology
  attr_reader :id

  attribute :start_date, :date
  attribute :end_date, :date
  attribute :author, :string
  attribute :diagnosis_name, :string
  attribute :diagnosis_code, :string
  attribute :diagnosis_terminoogy, :string

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

  def orca_connection
    @orca_con ||= Base.orca_connection
  end

  def save
    res = self.connection.post("composition", {query: {'format' => 'FLAT', 'templateId' => 'diagnosis_list.v.0.0.5', 'ehrId' => @ehr_id}, body: body, header: {'Content-Type' => 'application/json'}})
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

    @version = JSON.parse(res.body)['meta']['href']['url'].split('::')[1]
    res
  end

  def body
    @start_time = Time.now.iso8601
    body = <<"END"
{
    "ctx/language": "en",
    "ctx/territory": "US",
    "ctx/composer_name": "#{@author}",
    "ctx/id_namespace": "Wako hospital",
    "ctx/id_scheme": "Wako hospital",
    "ctx/participation_name": "#{@author}",
    "ctx/participation_function": "requester",
    "ctx/participation_mode": "tele-communication", 
    "ctx/participation_id": "12345",
    "ctx/health_care_facility|name": "Wako Hospital",
    "ctx/health_care_facility|id": "9999",
    "diagnosis_list/problem_list/problem_diagnosis/problem_diagnosis_name|code": "#{@diagnosis_code}",
    "diagnosis_list/problem_list/problem_diagnosis/problem_diagnosis_name|value": "#{@diagnosis_name}",
    "diagnosis_list/problem_list/problem_diagnosis/problem_diagnosis_name|terminology": "#{@diagnosis_terminology}",
    "diagnosis_list/problem_list/problem_diagnosis/date_time_of_onset": "#{@start_date}",
    "diagnosis_list/problem_list/problem_diagnosis/last_updated": "#{Time.now.iso8601}"
}
END
  end
#    "diagnosis_list/problem_list/problem_diagnosis/date_time_of_resolution": "#{@end_date}",

  def orca_message
    @start_time = Time.now.iso8601
    message_body = <<"END"
<data>
  <diseasereq type="record">
    <Patient_ID type="string">#{@ehr.person.orca_id}</Patient_ID>
    <Base_Month type="string"></Base_Month>
    <Perform_Date type="string">#{@start_time}</Perform_Date>
    <Perform_Time type="string"></Perform_Time>
    <Diagnosis_Information type="record">
      <Department_Code type="string">01</Department_Code>
    </Diagnosis_Information>
    <Disease_Information type="array">
      <Disease_Information_child type="record">
        <Disease_Insurance_Class type="string"></Disease_Insurance_Class>
        <Disease_Code type="string">#{@diagnosis_code}</Disease_Code>
        <Disease_Name type="string">#{@diagnosis_name}</Disease_Name>
        <Disease_Single type="array">
          <Disease_Single_child type="record">
            <Disease_Single_Code type= "string"></Disease_Single_Code>
            <Disease_Single_Name type= "string"></Disease_Single_Name>
          </Disease_Single_child>
        </Disease_Single>
        <Disease_Supplement_Name type= "string"></Disease_Supplement_Name>
        <Disease_Supplement_Single type="array">
          <Disease_Supplement_Single_child type="record">
            <Disease_Supplement_Single_Code type= "string"></Disease_Supplement_Single_Code>
          </Disease_Supplement_Single_child>
        </Disease_Supplement_Single>
        <Disease_InOut type="string">O</Disease_InOut>
        <Disease_Category type="string"></Disease_Category>
        <Disease_SuspectedFlag type="string"></Disease_SuspectedFlag>
        <Disease_StartDate type="string">2017-08-21</Disease_StartDate>
        <Disease_EndDate type="string"></Disease_EndDate>
        <Disease_OutCome type="string"></Disease_OutCome>
        <Disease_Karte_Name type="string"></Disease_Karte_Name>
        <Disease_Class type="string"></Disease_Class>
        <Insurance_Combination_Number type="string"></Insurance_Combination_Number>

        <Disease_Receipt_Print type="string"></Disease_Receipt_Print>
        <Disease_Receipt_Print_Period type="string"></Disease_Receipt_Print_Period>
        <Insurance_Disease type="string"></Insurance_Disease>
        <Discharge_Certificate type="string"></Discharge_Certificate>
        <Main_Disease_Class type="string"></Main_Disease_Class>
        <Sub_Disease_Class type="string"></Sub_Disease_Class>
      </Disease_Information_child>
    </Disease_Information>
  </diseasereq>
</data>
END
  end

  def update
    
  end


  def save_to_orca
    @ehr = Ehr.find(@ehr_id)
    res = self.orca_connection.post('orca22/diseasev3', {query: {'class' => '01'}, body: orca_message})
p res.body
    
    res
  end
  
  class << self
    def connection
      @con ||= HTTPClient.new(base_url: "#{EHRbase.scheme}://#{EHRbase.host}:#{EHRbase.port}/ehrbase/rest/ecis/v1/",
                            user: EHRbase.username,
                            password: EHRbase.password)
    end

    def find_by_ehr_id(ehr_id)
      aql = "select c from EHR [ehr_id/value='#{ehr_id}'] CONTAINS COMPOSITION c[openEHR-EHR-COMPOSITION.problem_list.v2] where c/archetype_details/template_id/value = 'diagnosis_list.v.0.0.5'"
      query = { 'q' => aql }
      res = Base.connection.get('query/aql', query)

      JSON.parse(res.body)['rows'].map do |row|
        DiagnosesList.new(ehr_id: ehr_id,
                          id: row[0]['uid']['value'].split('::')[0],
                          # start_date: row[0]['content'][0]['items'][0]['data']['items'][2]['value']['value'],
                          # end_date: row[0]['content'][0]['items'][0]['data']['items'][1]['value']['value'],
                          diagnosis_terminology: row[0]['content'][0]['items'][0]['data']['items'][0]['value']['defining_code']['terminology_id']['value'],
                            diagnosis_name:  row[0]['content'][0]['items'][0]['data']['items'][0]['value']['value'],
                            diagnosis_code: row[0]['content'][0]['items'][0]['data']['items'][0]['value']['defining_code']['code_string'] )
      end
    end
    
    def find_by_id(ehr_id, diagnoses_list_id)
      res = Base.connection.get("ehr/#{ehr_id}/composition/#{diagnoses_list_id}")
      row = JSON.parse(res.body)
      
      DiagnosesList.new(ehr_id: ehr_id,
                        id: row['uid']['value'].split('::')[0],
                        start_date: row['content'][0]['items'][0]['data']['items'][2]['value']['value'],
                        end_date: row['content'][0]['items'][0]['data']['items'][1]['value']['value'],
                        diagnosis_terminology: row['content'][0]['items'][0]['data']['items'][0]['value']['defining_code']['terminology_id']['value'],
                        diagnosis_name:  row['content'][0]['items'][0]['data']['items'][0]['value']['value'],
                        diagnosis_code: row['content'][0]['items'][0]['data']['items'][0]['value']['defining_code']['code_string'] )
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
