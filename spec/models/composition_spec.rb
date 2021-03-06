# coding: utf-8
RSpec.describe Composition, type: :model do
  let(:ehr) { Ehr.create! }
  let(:composition) { Composition.create!(ehr_id: ehr.id,
                                          body: File.read(
                                            Rails.root.join('spec',
                                                            'factories',
                                                            'composition_sample_body.json')))}

  describe '#create' do
    it 'should post a composition to create a record in EHRbase via REST API' do
      expect(composition).to be_valid
    end

    it 'should save properly' do
      res = composition.save
      expect(res.status).to eq 204
    end

    it 'should have one EHR' do
      expect(composition.ehr.id).not_to be_nil
    end
  end

  describe '#read' do
    it 'should get the composition by id from EHRbase via REST API' do
      body = JSON.parse Composition.find_by_id(composition.ehr_id, composition.id).body
      expect( body['name']['value']).to eq 'Health summary'
    end

    it 'should get the list of composition by EHR ID from EHRbase via REST API' do
      composition.save
      expect(Composition.find_by_ehr_id(ehr.id).size).to be >= 1
    end
  end

  describe '#update' do
    it 'should update the composition by id in EHRbase via REST API' do
      old_version = composition.save.version
      composition.update(body: UPDATE_BODY)
      expect(composition.version).to eq "#{old_version.to_i + 1}"
    end
  end

  describe '#delete' do
    it 'should delete the composition by id in EHRbase via REST API' do
      res = composition.delete
      expect(res.status).to eq 204
    end
  end

  xdescribe '#all' do
    it 'should get all compositions by EHR_id'
  end
end

BODY=<<END
{
    "name": {
        "_type": "DV_TEXT",
        "value": "Health summary"
    },
    "archetype_details": {
        "_type": "ARCHETYPED",
        "archetype_id": {
            "_type": "ARCHETYPE_ID",
            "value": "openEHR-EHR-COMPOSITION.health_summary.v1"
        },
        "template_id": {
            "_type": "TEMPLATE_ID",
            "value": "symptom_screening"
        },
        "rm_version": "1.0.4"
    },
    "archetype_node_id": "openEHR-EHR-COMPOSITION.health_summary.v1",
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
            "code_string": "433"
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
            "value": "2020-09-22T16:18:51.481222+02:00"
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
            "external_ref": {
                "_type": "PARTY_REF",
                "id": {
                    "_type": "GENERIC_ID",
                    "value": "9091",
                    "scheme": "Wako Hospital"
                },
                "namespace": "Wako hospital",
                "type": "PARTY"
            },
            "name": "Wako Hospital"
        },
        "participations": [
            {
                "_type": "PARTICIPATION",
                "function": {
                    "_type": "DV_TEXT",
                    "value": "requester"
                },
                "performer": {
                    "_type": "PARTY_IDENTIFIED",
                    "external_ref": {
                        "_type": "PARTY_REF",
                        "id": {
                            "_type": "GENERIC_ID",
                            "value": "199",
                            "scheme": "Wako Hospital"
                        },
                        "namespace": "Wako hospital",
                        "type": "ANY"
                    },
                    "name": "Dr. Shinji Kobayashi"
                },
                "mode": {
                    "_type": "DV_CODED_TEXT",
                    "value": "face-to-face communication",
                    "defining_code": {
                        "_type": "CODE_PHRASE",
                        "terminology_id": {
                            "_type": "TERMINOLOGY_ID",
                            "value": "openehr"
                        },
                        "code_string": "216"
                    }
                }
            },
            {
                "_type": "PARTICIPATION",
                "function": {
                    "_type": "DV_TEXT",
                    "value": "performer"
                },
                "performer": {
                    "_type": "PARTY_IDENTIFIED",
                    "external_ref": {
                        "_type": "PARTY_REF",
                        "id": {
                            "_type": "GENERIC_ID",
                            "value": "198",
                            "scheme": "Wako Hospital"
                        },
                        "namespace": "Wako hospital",
                        "type": "ANY"
                    },
                    "name": "Nurse 1"
                },
                "mode": {
                    "_type": "DV_CODED_TEXT",
                    "value": "not specified",
                    "defining_code": {
                        "_type": "CODE_PHRASE",
                        "terminology_id": {
                            "_type": "TERMINOLOGY_ID",
                            "value": "openehr"
                        },
                        "code_string": "193"
                    }
                }
            }
        ]
    },
    "content": [
        {
            "_type": "OBSERVATION",
            "name": {
                "_type": "DV_TEXT",
                "value": "Story/History"
            },
            "archetype_details": {
                "_type": "ARCHETYPED",
                "archetype_id": {
                    "_type": "ARCHETYPE_ID",
                    "value": "openEHR-EHR-OBSERVATION.story.v1"
                },
                "rm_version": "1.0.4"
            },
            "archetype_node_id": "openEHR-EHR-OBSERVATION.story.v1",
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
            "other_participations": [
                {
                    "_type": "PARTICIPATION",
                    "function": {
                        "_type": "DV_TEXT",
                        "value": "requester"
                    },
                    "performer": {
                        "_type": "PARTY_IDENTIFIED",
                        "external_ref": {
                            "_type": "PARTY_REF",
                            "id": {
                                "_type": "GENERIC_ID",
                                "value": "199",
                                "scheme": "Wako Hospital"
                            },
                            "namespace": "Wako hospital",
                            "type": "ANY"
                        },
                        "name": "Dr. Shinji Kobayashi"
                    },
                    "mode": {
                        "_type": "DV_CODED_TEXT",
                        "value": "face-to-face communication",
                        "defining_code": {
                            "_type": "CODE_PHRASE",
                            "terminology_id": {
                                "_type": "TERMINOLOGY_ID",
                                "value": "openehr"
                            },
                            "code_string": "216"
                        }
                    }
                },
                {
                    "_type": "PARTICIPATION",
                    "function": {
                        "_type": "DV_TEXT",
                        "value": "performer"
                    },
                    "performer": {
                        "_type": "PARTY_IDENTIFIED",
                        "external_ref": {
                            "_type": "PARTY_REF",
                            "id": {
                                "_type": "GENERIC_ID",
                                "value": "198",
                                "scheme": "Wako Hospital"
                            },
                            "namespace": "Wako hospital",
                            "type": "ANY"
                        },
                        "name": "Nurse 1"
                    },
                    "mode": {
                        "_type": "DV_CODED_TEXT",
                        "value": "not specified",
                        "defining_code": {
                            "_type": "CODE_PHRASE",
                            "terminology_id": {
                                "_type": "TERMINOLOGY_ID",
                                "value": "openehr"
                            },
                            "code_string": "193"
                        }
                    }
                }
            ],
            "data": {
                "_type": "HISTORY",
                "name": {
                    "_type": "DV_TEXT",
                    "value": "Event Series"
                },
                "archetype_node_id": "at0001",
                "origin": {
                    "_type": "DV_DATE_TIME",
                    "value": "2020-09-22T16:18:51.481222+02:00"
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
                            "value": "2020-09-22T16:18:51.481222+02:00"
                        },
                        "data": {
                            "_type": "ITEM_TREE",
                            "name": {
                                "_type": "DV_TEXT",
                                "value": "Tree"
                            },
                            "archetype_node_id": "at0003",
                            "items": [
                                {
                                    "_type": "ELEMENT",
                                    "name": {
                                        "_type": "DV_TEXT",
                                        "value": "Story"
                                    },
                                    "archetype_node_id": "at0004",
                                    "value": {
                                        "_type": "DV_TEXT",
                                        "value": "4日前より発熱。解熱せず呼吸器症状悪化"
                                    }
                                },
                                {
                                    "_type": "CLUSTER",
                                    "name": {
                                        "_type": "DV_TEXT",
                                        "value": "Symptom/Sign"
                                    },
                                    "archetype_details": {
                                        "_type": "ARCHETYPED",
                                        "archetype_id": {
                                            "_type": "ARCHETYPE_ID",
                                            "value": "openEHR-EHR-CLUSTER.symptom_sign.v1"
                                        },
                                        "rm_version": "1.0.4"
                                    },
                                    "archetype_node_id": "openEHR-EHR-CLUSTER.symptom_sign.v1",
                                    "items": [
                                        {
                                            "_type": "ELEMENT",
                                            "name": {
                                                "_type": "DV_TEXT",
                                                "value": "Symptom/Sign name"
                                            },
                                            "archetype_node_id": "at0001",
                                            "value": {
                                                "_type": "DV_TEXT",
                                                "value": "咳、鼻水"
                                            }
                                        }
                                    ]
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
            "other_participations": [
                {
                    "_type": "PARTICIPATION",
                    "function": {
                        "_type": "DV_TEXT",
                        "value": "requester"
                    },
                    "performer": {
                        "_type": "PARTY_IDENTIFIED",
                        "external_ref": {
                            "_type": "PARTY_REF",
                            "id": {
                                "_type": "GENERIC_ID",
                                "value": "199",
                                "scheme": "Wako Hospital"
                            },
                            "namespace": "Wako hospital",
                            "type": "ANY"
                        },
                        "name": "Dr. Shinji Kobayashi"
                    },
                    "mode": {
                        "_type": "DV_CODED_TEXT",
                        "value": "face-to-face communication",
                        "defining_code": {
                            "_type": "CODE_PHRASE",
                            "terminology_id": {
                                "_type": "TERMINOLOGY_ID",
                                "value": "openehr"
                            },
                            "code_string": "216"
                        }
                    }
                },
                {
                    "_type": "PARTICIPATION",
                    "function": {
                        "_type": "DV_TEXT",
                        "value": "performer"
                    },
                    "performer": {
                        "_type": "PARTY_IDENTIFIED",
                        "external_ref": {
                            "_type": "PARTY_REF",
                            "id": {
                                "_type": "GENERIC_ID",
                                "value": "198",
                                "scheme": "Wako Hospital"
                            },
                            "namespace": "Wako hospital",
                            "type": "ANY"
                        },
                        "name": "Nurse 1"
                    },
                    "mode": {
                        "_type": "DV_CODED_TEXT",
                        "value": "not specified",
                        "defining_code": {
                            "_type": "CODE_PHRASE",
                            "terminology_id": {
                                "_type": "TERMINOLOGY_ID",
                                "value": "openehr"
                            },
                            "code_string": "193"
                        }
                    }
                }
            ],
            "data": {
                "_type": "HISTORY",
                "name": {
                    "_type": "DV_TEXT",
                    "value": "Event Series"
                },
                "archetype_node_id": "at0001",
                "origin": {
                    "_type": "DV_DATE_TIME",
                    "value": "2020-09-22T16:18:51.481222+02:00"
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
                            "value": "2020-09-22T16:18:51.481222+02:00"
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
                                        "magnitude": 37.0,
                                        "units": "°C"
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

UPDATE_BODY=<<END
{
    "name": {
        "_type": "DV_TEXT",
        "value": "Health summary"
    },
    "archetype_details": {
        "_type": "ARCHETYPED",
        "archetype_id": {
            "_type": "ARCHETYPE_ID",
            "value": "openEHR-EHR-COMPOSITION.health_summary.v1"
        },
        "template_id": {
            "_type": "TEMPLATE_ID",
            "value": "symptom_screening"
        },
        "rm_version": "1.0.4"
    },
    "archetype_node_id": "openEHR-EHR-COMPOSITION.health_summary.v1",
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
            "value": "2020-09-22T16:18:51.481222+02:00"
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
            "external_ref": {
                "_type": "PARTY_REF",
                "id": {
                    "_type": "GENERIC_ID",
                    "value": "9091",
                    "scheme": "Wako Hospital"
                },
                "namespace": "Wako hospital",
                "type": "PARTY"
            },
            "name": "Wako Hospital"
        },
        "participations": [
            {
                "_type": "PARTICIPATION",
                "function": {
                    "_type": "DV_TEXT",
                    "value": "requester"
                },
                "performer": {
                    "_type": "PARTY_IDENTIFIED",
                    "external_ref": {
                        "_type": "PARTY_REF",
                        "id": {
                            "_type": "GENERIC_ID",
                            "value": "199",
                            "scheme": "Wako Hospital"
                        },
                        "namespace": "Wako hospital",
                        "type": "ANY"
                    },
                    "name": "Dr. Shinji Kobayashi"
                },
                "mode": {
                    "_type": "DV_CODED_TEXT",
                    "value": "face-to-face communication",
                    "defining_code": {
                        "_type": "CODE_PHRASE",
                        "terminology_id": {
                            "_type": "TERMINOLOGY_ID",
                            "value": "openehr"
                        },
                        "code_string": "216"
                    }
                }
            },
            {
                "_type": "PARTICIPATION",
                "function": {
                    "_type": "DV_TEXT",
                    "value": "performer"
                },
                "performer": {
                    "_type": "PARTY_IDENTIFIED",
                    "external_ref": {
                        "_type": "PARTY_REF",
                        "id": {
                            "_type": "GENERIC_ID",
                            "value": "198",
                            "scheme": "Wako Hospital"
                        },
                        "namespace": "Wako hospital",
                        "type": "ANY"
                    },
                    "name": "Nurse 1"
                },
                "mode": {
                    "_type": "DV_CODED_TEXT",
                    "value": "not specified",
                    "defining_code": {
                        "_type": "CODE_PHRASE",
                        "terminology_id": {
                            "_type": "TERMINOLOGY_ID",
                            "value": "openehr"
                        },
                        "code_string": "193"
                    }
                }
            }
        ]
    },
    "content": [
        {
            "_type": "OBSERVATION",
            "name": {
                "_type": "DV_TEXT",
                "value": "Story/History"
            },
            "archetype_details": {
                "_type": "ARCHETYPED",
                "archetype_id": {
                    "_type": "ARCHETYPE_ID",
                    "value": "openEHR-EHR-OBSERVATION.story.v1"
                },
                "rm_version": "1.0.4"
            },
            "archetype_node_id": "openEHR-EHR-OBSERVATION.story.v1",
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
            "other_participations": [
                {
                    "_type": "PARTICIPATION",
                    "function": {
                        "_type": "DV_TEXT",
                        "value": "requester"
                    },
                    "performer": {
                        "_type": "PARTY_IDENTIFIED",
                        "external_ref": {
                            "_type": "PARTY_REF",
                            "id": {
                                "_type": "GENERIC_ID",
                                "value": "199",
                                "scheme": "Wako Hospital"
                            },
                            "namespace": "Wako hospital",
                            "type": "ANY"
                        },
                        "name": "Dr. Shinji Kobayashi"
                    },
                    "mode": {
                        "_type": "DV_CODED_TEXT",
                        "value": "face-to-face communication",
                        "defining_code": {
                            "_type": "CODE_PHRASE",
                            "terminology_id": {
                                "_type": "TERMINOLOGY_ID",
                                "value": "openehr"
                            },
                            "code_string": "216"
                        }
                    }
                },
                {
                    "_type": "PARTICIPATION",
                    "function": {
                        "_type": "DV_TEXT",
                        "value": "performer"
                    },
                    "performer": {
                        "_type": "PARTY_IDENTIFIED",
                        "external_ref": {
                            "_type": "PARTY_REF",
                            "id": {
                                "_type": "GENERIC_ID",
                                "value": "198",
                                "scheme": "Wako Hospital"
                            },
                            "namespace": "Wako hospital",
                            "type": "ANY"
                        },
                        "name": "Nurse 1"
                    },
                    "mode": {
                        "_type": "DV_CODED_TEXT",
                        "value": "not specified",
                        "defining_code": {
                            "_type": "CODE_PHRASE",
                            "terminology_id": {
                                "_type": "TERMINOLOGY_ID",
                                "value": "openehr"
                            },
                            "code_string": "193"
                        }
                    }
                }
            ],
            "data": {
                "_type": "HISTORY",
                "name": {
                    "_type": "DV_TEXT",
                    "value": "Event Series"
                },
                "archetype_node_id": "at0001",
                "origin": {
                    "_type": "DV_DATE_TIME",
                    "value": "2020-09-22T16:18:51.481222+02:00"
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
                            "value": "2020-09-22T16:18:51.481222+02:00"
                        },
                        "data": {
                            "_type": "ITEM_TREE",
                            "name": {
                                "_type": "DV_TEXT",
                                "value": "Tree"
                            },
                            "archetype_node_id": "at0003",
                            "items": [
                                {
                                    "_type": "ELEMENT",
                                    "name": {
                                        "_type": "DV_TEXT",
                                        "value": "Story"
                                    },
                                    "archetype_node_id": "at0004",
                                    "value": {
                                        "_type": "DV_TEXT",
                                        "value": "4日前より発熱。解熱せず呼吸器症状悪化"
                                    }
                                },
                                {
                                    "_type": "CLUSTER",
                                    "name": {
                                        "_type": "DV_TEXT",
                                        "value": "Symptom/Sign"
                                    },
                                    "archetype_details": {
                                        "_type": "ARCHETYPED",
                                        "archetype_id": {
                                            "_type": "ARCHETYPE_ID",
                                            "value": "openEHR-EHR-CLUSTER.symptom_sign.v1"
                                        },
                                        "rm_version": "1.0.4"
                                    },
                                    "archetype_node_id": "openEHR-EHR-CLUSTER.symptom_sign.v1",
                                    "items": [
                                        {
                                            "_type": "ELEMENT",
                                            "name": {
                                                "_type": "DV_TEXT",
                                                "value": "Symptom/Sign name"
                                            },
                                            "archetype_node_id": "at0001",
                                            "value": {
                                                "_type": "DV_TEXT",
                                                "value": "呼吸困難"
                                            }
                                        }
                                    ]
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
            "other_participations": [
                {
                    "_type": "PARTICIPATION",
                    "function": {
                        "_type": "DV_TEXT",
                        "value": "requester"
                    },
                    "performer": {
                        "_type": "PARTY_IDENTIFIED",
                        "external_ref": {
                            "_type": "PARTY_REF",
                            "id": {
                                "_type": "GENERIC_ID",
                                "value": "199",
                                "scheme": "Wako Hospital"
                            },
                            "namespace": "Wako hospital",
                            "type": "ANY"
                        },
                        "name": "Dr. Shinji Kobayashi"
                    },
                    "mode": {
                        "_type": "DV_CODED_TEXT",
                        "value": "face-to-face communication",
                        "defining_code": {
                            "_type": "CODE_PHRASE",
                            "terminology_id": {
                                "_type": "TERMINOLOGY_ID",
                                "value": "openehr"
                            },
                            "code_string": "216"
                        }
                    }
                },
                {
                    "_type": "PARTICIPATION",
                    "function": {
                        "_type": "DV_TEXT",
                        "value": "performer"
                    },
                    "performer": {
                        "_type": "PARTY_IDENTIFIED",
                        "external_ref": {
                            "_type": "PARTY_REF",
                            "id": {
                                "_type": "GENERIC_ID",
                                "value": "198",
                                "scheme": "Wako Hospital"
                            },
                            "namespace": "Wako hospital",
                            "type": "ANY"
                        },
                        "name": "Nurse 1"
                    },
                    "mode": {
                        "_type": "DV_CODED_TEXT",
                        "value": "not specified",
                        "defining_code": {
                            "_type": "CODE_PHRASE",
                            "terminology_id": {
                                "_type": "TERMINOLOGY_ID",
                                "value": "openehr"
                            },
                            "code_string": "193"
                        }
                    }
                }
            ],
            "data": {
                "_type": "HISTORY",
                "name": {
                    "_type": "DV_TEXT",
                    "value": "Event Series"
                },
                "archetype_node_id": "at0001",
                "origin": {
                    "_type": "DV_DATE_TIME",
                    "value": "2020-09-22T16:18:51.481222+02:00"
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
                            "value": "2020-09-22T16:18:51.481222+02:00"
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
                                        "magnitude": 38.5,
                                        "units": "°C"
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

