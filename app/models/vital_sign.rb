# coding: utf-8
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
    "name": {
        "_type": "DV_TEXT",
        "value": "Progress Note"
    },
    "archetype_details": {
        "_type": "ARCHETYPED",
        "archetype_id": {
            "_type": "ARCHETYPE_ID",
            "value": "openEHR-EHR-COMPOSITION.progress_note.v0"
        },
        "template_id": {
                "_type": "TEMPLATE_ID",
                "value": "ICU_VITAL_SIGNS"
            },
            "rm_version": "1.0.4"
        },
        "archetype_node_id": "openEHR-EHR-COMPOSITION.progress_note.v0",
        "language": {
            "_type": "CODE_PHRASE",
            "terminology_id": {
                "_type": "TERMINOLOGY_ID",
                "value": "ISO_639-1"
            },
            "code_string": "en"
        },
        "territory": {
            "_type": "CODE_PHRASE",
            "terminology_id": {
                "_type": "TERMINOLOGY_ID",
                "value": "ISO_3166-1"
            },
            "code_string": "JP"
        },
        "category": {
            "_type": "DV_CODED_TEXT",
            "value": "event",
            "defining_code": {
                "_type": "CODE_PHRASE",
                "terminology_id": {
                    "_type": "TERMINOLOGY_ID",
                    "value": "openehr"
                },
                "code_string": 433
            }
        },
        "composer": {
            "_type": "PARTY_IDENTIFIED",
            "name": "Shinji Kobayashi"
        },
        "context": {
            "_type": "EVENT_CONTEXT",
            "start_time": {
                "_type": "DV_DATE_TIME",
                "value": "#{params[:start_date]}"
            },
            "setting": {
                "_type": "DV_CODED_TEXT",
                "value": "other care",
                "defining_code": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "openehr"
                    },
                    "code_string": "238"
                }
            },
            "health_care_facility": {
                "_type": "PARTY_IDENTIFIED",
                "name": "Wako Hospital"
            }
        },
        "content": [
	    {
                "_type": "OBSERVATION",
                "name": {
                    "_type": "DV_TEXT",
                    "value": "Temperature"
                },
                "archetype_details": {
                    "_type": "ARCHETYPED",
                    "archetype_id": {
                        "_type": "ARCHETYPE_ID",
                        "value": "openEHR-EHR-OBSERVATION.temperature.v1"
                    },
                    "rm_version": "1.0.4"
                },
                "archetype_node_id": "openEHR-EHR-OBSERVATION.temperature.v1",
                "language": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "ISO_639-1"
                    },
                    "code_string": "ja"
                },
                "encoding": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "IANA_character-sets"
                    },
                    "code_string": "UTF-8"
                },
                "subject": {
                    "_type": "PARTY_SELF"
                },
                "data": {
                    "_type": "HISTORY",
                    "name": {
                        "_type": "DV_TEXT",
                        "value": "Event Series"
                    },
                    "archetype_node_id": "at0001",
                    "origin": {
                        "_type": "DV_DATE_TIME",
                        "value": "#{params[:start_date]}"
                    },
                    "events": [
                        {
                            "_type": "POINT_EVENT",
                            "name": {
                                "_type": "DV_TEXT",
                                "value": "Any event"
                            },
                            "archetype_node_id": "at0002",
                            "time": {
                                "_type": "DV_DATE_TIME",
                                "value": "#{params[:start_date]}"
                            },
                            "data": {
                                "_type": "ITEM_LIST",
                                "name": {
                                    "_type": "DV_TEXT",
                                    "value": "Single"
                                },
                                "archetype_node_id": "at0003",
                                "items": [
                                    {
                                        "_type": "ELEMENT",
                                        "name": {
                                            "_type": "DV_TEXT",
                                            "value": "Temperature"
                                        },
                                        "archetype_node_id": "at0004",
                                        "value": {
                                            "_type": "DV_QUANTITY",
                                            "magnitude": #{params[:temperature]},
                                            "units": "°C"
                                        }
                                    }
                                ]
                            }
                        }
                    ]
                }
            },
            {
                "_type": "OBSERVATION",
                "name": {
                    "_type": "DV_TEXT",
                    "value": "Pulse/Heart beat"
                },
                "archetype_details": {
                    "_type": "ARCHETYPED",
                    "archetype_id": {
                        "_type": "ARCHETYPE_ID",
                        "value": "openEHR-EHR-OBSERVATION.pulse.v2"
                    },
                    "rm_version": "1.0.4"
                },
                "archetype_node_id": "openEHR-EHR-OBSERVATION.pulse.v2",
                "language": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "ISO_639-1"
                    },
                    "code_string": "ja"
                },
                "encoding": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "IANA_character-sets"
                    },
                    "code_string": "UTF-8"
                },
                "subject": {
                    "_type": "PARTY_SELF"
                },
                "data": {
                    "_type": "HISTORY",
                    "name": {
                        "_type": "DV_TEXT",
                        "value": "Event Series"
                    },
                    "archetype_node_id": "at0002",
                    "origin": {
                        "_type": "DV_DATE_TIME",
                        "value": "#{params[:start_date]}"
                    },
                    "events": [
                        {
                            "_type": "POINT_EVENT",
                            "name": {
                                "_type": "DV_TEXT",
                                "value": "Any event"
                            },
                            "archetype_node_id": "at0003",
                            "time": {
                                "_type": "DV_DATE_TIME",
                                "value": "#{params[:start_date]}"
                            },
                            "data": {
                                "_type": "ITEM_LIST",
                                "name": {
                                    "_type": "DV_TEXT",
                                    "value": "Single"
                                },
                                "archetype_node_id": "at0001",
                                "items": [
                                    {
                                        "_type": "ELEMENT",
                                        "name": {
                                            "_type": "DV_TEXT",
                                            "value": "Temperature"
                                        },
                                        "archetype_node_id": "at0004",
                                        "value": {
                                            "_type": "DV_QUANTITY",
                                            "magnitude": #{params[:heart_rate]},
                                            "units": "/min"
                                        }
                                    }
                                ]
                            }
                        }
                    ]
                }           
            },
            {
                "_type": "OBSERVATION",
                "name": {
                    "_type": "DV_TEXT",
                    "value": "Blood pressure"
                },
                "archetype_details": {
                    "_type": "ARCHETYPED",
                    "archetype_id": {
                        "_type": "ARCHETYPE_ID",
                        "value": "openEHR-EHR-OBSERVATION.blood_pressure.v2"
                    },
                    "rm_version": "1.0.4"
                },
                "archetype_node_id": "openEHR-EHR-OBSERVATION.blood_pressure.v2",
                "language": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "ISO_639-1"
                    },
                    "code_string": "ja"
                },
                "encoding": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "IANA_character-sets"
                    },
                    "code_string": "UTF-8"
                },
                "subject": {
                    "_type": "PARTY_SELF"
                },
                "data": {
                    "_type": "HISTORY",
                    "name": {
                        "_type": "DV_TEXT",
                        "value": "Event Series"
                    },
                    "archetype_node_id": "at0001",
                    "origin": {
                        "_type": "DV_DATE_TIME",
                        "value": "#{params[:start_date]}"
                    },
                    "events": [
                        {
                            "_type": "POINT_EVENT",
                            "name": {
                                "_type": "DV_TEXT",
                                "value": "Any event"
                            },
                            "archetype_node_id": "at0006",
                            "time": {
                                "_type": "DV_DATE_TIME",
                                "value": "#{params[:start_date]}"
                            },
                            "data": {
                                "_type": "ITEM_LIST",
                                "name": {
                                    "_type": "DV_TEXT",
                                    "value": "Single"
                                },
                                "archetype_node_id": "at0003",
                                "items": [
                                    {
                                        "_type": "ELEMENT",
                                        "name": {
                                            "_type": "DV_TEXT",
                                            "value": "Systolic"
                                        },
                                        "archetype_node_id": "at0004",
                                        "value": {
                                            "_type": "DV_QUANTITY",
                                            "magnitude": #{params[:systolic_pressure]},
                                            "units": "mm[Hg]"
                                        }
                                    },
                                    {
                                        "_type": "ELEMENT",
                                        "name": {
                                            "_type": "DV_TEXT",
                                            "value": "Diastolic"
                                        },
                                        "archetype_node_id": "at0005",
                                        "value": {
                                            "_type": "DV_QUANTITY",
                                            "magnitude": #{params[:diastolic_pressure]},
                                            "units": "mm[Hg]"
                                        }
                                    },
                                    {
                                        "_type": "ELEMENT",
                                        "name": {
                                            "_type": "DV_TEXT",
                                            "value": "Mean arterial pressure"
                                        },
                                        "archetype_node_id": "at1006",
                                        "value": {
                                            "_type": "DV_QUANTITY",
                                            "magnitude": #{params[:mean_arterial_pressure]},
                                            "units": "mm[Hg]"
                                        }
                                    }
                                ]
                            }
                        }
                    ]
                }  
            },
            {
                "_type": "OBSERVATION",
                "name": {
                    "_type": "DV_TEXT",
                    "value": "Pulse oximetry"
                },
                "archetype_details": {
                    "_type": "ARCHETYPED",
                    "archetype_id": {
                        "_type": "ARCHETYPE_ID",
                        "value": "openEHR-EHR-OBSERVATION.pulse_oximetry.v1"
                    },
                    "rm_version": "1.0.4"
                },
                "archetype_node_id": "openEHR-EHR-OBSERVATION.pulse_oximetry.v1",
                "language": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "ISO_639-1"
                    },
                    "code_string": "ja"
                },
                "encoding": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "IANA_character-sets"
                    },
                    "code_string": "UTF-8"
                },
                "subject": {
                    "_type": "PARTY_SELF"
                },
                "data": {
                    "_type": "HISTORY",
                    "name": {
                        "_type": "DV_TEXT",
                        "value": "Event Series"
                    },
                    "archetype_node_id": "at0001",
                    "origin": {
                        "_type": "DV_DATE_TIME",
                        "value": "#{params[:start_date]}"
                    },
                    "events": [
                        {
                            "_type": "POINT_EVENT",
                            "name": {
                                "_type": "DV_TEXT",
                                "value": "Any event"
                            },
                            "archetype_node_id": "at0002",
                            "time": {
                                "_type": "DV_DATE_TIME",
                                "value": "#{params[:start_date]}"
                            },
                            "data": {
                                "_type": "ITEM_LIST",
                                "name": {
                                    "_type": "DV_TEXT",
                                    "value": "Single"
                                },
                                "archetype_node_id": "at0003",
                                "items": [
                                    {
                                        "_type": "ELEMENT",
                                        "name": {
                                            "_type": "DV_TEXT",
                                            "value": "SpO₂"
                                        },
                                        "archetype_node_id": "at0006",
                                        "value": {
                                            "_type": "DV_PROPORTION",
                                            "numerator": #{params[:spo2]},
                                            "denominator": 100.0,
                                            "type": 2
                                        }
                                    }
                                ]
                            }
                        }
                    ]
                }
            },
            {
                "_type": "OBSERVATION",
                "name": {
                    "_type": "DV_TEXT",
                    "value": "Respiration"
                },
                "archetype_details": {
                    "_type": "ARCHETYPED",
                    "archetype_id": {
                        "_type": "ARCHETYPE_ID",
                        "value": "openEHR-EHR-OBSERVATION.respiration.v2"
                    },
                    "rm_version": "1.0.4"
                },
                "archetype_node_id": "openEHR-EHR-OBSERVATION.respiration.v2",
                "language": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "ISO_639-1"
                    },
                    "code_string": "ja"
                },
                "encoding": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "IANA_character-sets"
                    },
                    "code_string": "UTF-8"
                },
                "subject": {
                    "_type": "PARTY_SELF"
                },
                "data": {
                    "_type": "HISTORY",
                    "name": {
                        "_type": "DV_TEXT",
                        "value": "Event Series"
                    },
                    "archetype_node_id": "at0001",
                    "origin": {
                        "_type": "DV_DATE_TIME",
                        "value": "#{params[:start_date]}"
                    },
                    "events": [
                        {
                            "_type": "POINT_EVENT",
                            "name": {
                                "_type": "DV_TEXT",
                                "value": "Any event"
                            },
                            "archetype_node_id": "at0002",
                            "time": {
                                "_type": "DV_DATE_TIME",
                                "value": "#{params[:start_date]}"
                            },
                            "data": {
                                "_type": "ITEM_LIST",
                                "name": {
                                    "_type": "DV_TEXT",
                                    "value": "Single"
                                },
                                "archetype_node_id": "at0003",
                                "items": [
                                    {
                                        "_type": "ELEMENT",
                                        "name": {
                                            "_type": "DV_TEXT",
                                            "value": "Rate"
                                        },
                                        "archetype_node_id": "at0004",
                                        "value": {
                                            "_type": "DV_QUANTITY",
                                            "magnitude": #{params[:respiration_rate]},
                                            "units": "/min"
                                        }
                                    }
                                ]
                            }
                        }
                    ]
                } 
            },
            {
                "_type": "OBSERVATION",
                "name": {
                    "_type": "DV_TEXT",
                    "value": "Intravascular pressure"
                },
                "archetype_details": {
                    "_type": "ARCHETYPED",
                    "archetype_id": {
                        "_type": "ARCHETYPE_ID",
                        "value": "openEHR-EHR-OBSERVATION.intravascular_pressure.v0"
                    },
                    "rm_version": "1.0.4"
                },
                "archetype_node_id": "openEHR-EHR-OBSERVATION.intravascular_pressure.v0",
                "language": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "ISO_639-1"
                    },
                    "code_string": "ja"
                },
                "encoding": {
                    "_type": "CODE_PHRASE",
                    "terminology_id": {
                        "_type": "TERMINOLOGY_ID",
                        "value": "IANA_character-sets"
                    },
                    "code_string": "UTF-8"
                },
                "subject": {
                    "_type": "PARTY_SELF"
                },
                "data": {
                    "_type": "HISTORY",
                    "name": {
                        "_type": "DV_TEXT",
                        "value": "Event Series"
                    },
                    "archetype_node_id": "at0001",
                    "origin": {
                        "_type": "DV_DATE_TIME",
                        "value": "#{params[:start_date]}"
                    },
                    "events": [
                        {
                            "_type": "POINT_EVENT",
                            "name": {
                                "_type": "DV_TEXT",
                                "value": "Any event"
                            },
                            "archetype_node_id": "at0002",
                            "time": {
                                "_type": "DV_DATE_TIME",
                                "value": "#{params[:start_date]}"
                            },
                            "data": {
                                "_type": "ITEM_LIST",
                                "name": {
                                    "_type": "DV_TEXT",
                                    "value": "Single"
                                },
                                "archetype_node_id": "at0003",
                                "items": [
                                    {
                                        "_type": "ELEMENT",
                                        "name": {
                                            "_type": "DV_TEXT",
                                            "value": "Pressure"
                                        },
                                        "archetype_node_id": "at0005",
                                        "value": {
                                            "_type": "DV_QUANTITY",
                                            "magnitude": #{params[:intravascular_pressure]},
                                            "units": "mm[Hg]"
                                        }
                                    },
                                    {
                                        "_type": "ELEMENT",
                                        "name": {
                                            "_type": "DV_TEXT",
                                            "value": "PressurPhase of heart cycle"
                                        },
                                        "archetype_node_id": "at0007",
                                        "value": {
                                            "_type": "DV_CODED_TEXT",
                                            "value": "Systolic",
                                            "defining_code": {
                                                "code_string": "at0008",
                                                "terminology_id": "local"
                                            }
                                        }
                                    }
                                ]
                            }
                        }
                    ]
                }
            }
        ]
    }

END
     res = self.connection.post("composition/", {query: {'format' => 'FLAT', 'templateId' => 'ICU_VITAL_SIGNS', 'ehrId' => params[:ehr_id]}, body: vital_signs, header: {'Content-Type' => 'application/json'}})
     end
  end
  
end

