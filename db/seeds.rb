# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def body
  symptom = ['咳', '発熱', '倦怠感'][rand(0..2)]
  story = '3日前より発熱'
  temperature = (35.0 + rand(0.0..5.0)).round(1)
  composition = <<END
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
                                        "value": "#{story}"
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
                                                "value": "#{symptom}"
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
                                        "magnitude": #{temperature},
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
end

10.times do
  person = Person.create
  50.times do
    
  end
end
