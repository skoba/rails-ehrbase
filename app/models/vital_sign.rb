class VitalSign < Composition
  attribute :start_time, :datetime
  attribute :temperature, :decimal
  attribute :heart_rate, :decimal
  attribute :systolic_pressure, :decimal
  attribute :diastolic_pressure, :decimal
  attribute :mean_arterial_pressure, :decimal
  attribute :spo2, :decimal
  attribute :respiratin_rate, :decimal
  attribute :intravasculr_pressure, :decimal

  class << self
    def connection
      @con ||= HTTPClient.new(base_url: "#{EHRbase.scheme}://#{EHRbase.host}:#{EHRbase.port}/ehrbase/rest/ecis/v1/",
                              user: EHRbase.username,
                              password: EHRbase.password)
    end

    def create(params)
      vital_signs = <<"END"
{
    "ctx/language": "en",
    "ctx/territory": "US",
    "ctx/composer_name": "Shinji Kobayashi",
    "ctx/id_namespace": "Wako hospital,
    "ctx/id_scheme": "Wako hospital",
    "ctx/participation_name": "Shinji Kobayashi",
    "ctx/participation_function": "requester",
    "ctx/participation_mode": "face-to-face communication",
    "ctx/participation_id": "199",
    "ctx/participation_name:1": "Lara Markham",
    "ctx/participation_function:1": "performer",
    "ctx/participation_id:1": "198",
    "ctx/health_care_facility|name": "Hospital",
    "ctx/health_care_facility|id": "9091",
    "icu_vital_signs/body_temperature/any_event:0/temperature|magnitude": #{params[:temperature]},
    "icu_vital_signs/body_temperature/any_event:0/temperature|unit": "Cel",
    "icu_vital_signs/body_temperature/location_of_measurement|code": "at0055",
    "icu_vital_signs/pulse_heart_beat/any_event:0/rate|magnitude": #{params[:heart_rate]},
    "icu_vital_signs/pulse_heart_beat/any_event:0/rate|unit": "/min",
    "icu_vital_signs/blood_pressure/any_event:0/systolic|magnitude": #{params[:systolic_pressure]},
    "icu_vital_signs/blood_pressure/any_event:0/systolic|unit": "mm[Hg]",
    "icu_vital_signs/blood_pressure/any_event:0/diastolic|magnitude": #{params[:diastolic_pressure]},
    "icu_vital_signs/blood_pressure/any_event:0/diastolic|unit": "mm[Hg]",
    "icu_vital_signs/blood_pressure/any_event:0/mean_arterial_pressure|magnitude": #{params[:mean_arterial_pressure]},
    "icu_vital_signs/blood_pressure/any_event:0/mean_arterial_pressure|unit": "mm[Hg]",
    "icu_vital_signs/blood_pressure/location_of_measurement|code": "at1031",
    "icu_vital_signs/pulse_oximetry/any_event:0/spo|numerator": #{params[:spo2]},
    "icu_vital_signs/pulse_oximetry/any_event:0/spo|denominator": 100.0,
    "icu_vital_signs/pulse_oximetry/any_event:0/spo|type": 2,
    "icu_vital_signs/respiration/any_event:0/rate|magnitude": #{params[:respiration_rate]},
    "icu_vital_signs/respiration/any_event:0/rate|unit": "/min",
    "icu_vital_signs/intravascular_pressure/any_event:0/pressure|magnitude": #{params[:intravascular_pressure]},
    "icu_vital_signs/intravascular_pressure/any_event:0/pressure|unit": "mm[Hg]",
    "icu_vital_signs/intravascular_pressure/any_event:0/phase_of_heart_cycle|code": "at0027",
    "icu_vital_signs/intravascular_pressure/method": "Method 54"
}
END
     res = self.connection.post("composition/", {query: {'format' => 'FLAT', 'templateId' => 'ICU_VITAL_SIGNS', 'ehrId' => params[:ehr_id]}, body: vital_signs, header: {'Content-Type' => 'application/json'}})
     end
  end
  
end

