---
editable: false
---

# SmartWebSecurity API, gRPC: SecurityProfileService.Create

Creates a security profile in the specified folder using the data specified in the request.

## gRPC request

**rpc Create ([CreateSecurityProfileRequest](#yandex.cloud.smartwebsecurity.v1.CreateSecurityProfileRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSecurityProfileRequest {#yandex.cloud.smartwebsecurity.v1.CreateSecurityProfileRequest}

```json
{
  "folder_id": "string",
  "labels": "map<string, string>",
  "name": "string",
  "description": "string",
  "default_action": "DefaultAction",
  "security_rules": [
    {
      // Includes only one of the fields `rule_condition`, `smart_protection`, `waf`
      "rule_condition": {
        "action": "Action",
        "condition": {
          "authority": {
            "authorities": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "authority_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "http_method": {
            "http_methods": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "http_method_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "request_uri": {
            "path": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            },
            "queries": [
              {
                "key": "string",
                "value": {
                  // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                  "exact_match": "string",
                  "exact_not_match": "string",
                  "prefix_match": "string",
                  "prefix_not_match": "string",
                  "pire_regex_match": "string",
                  "pire_regex_not_match": "string",
                  "defined": "bool",
                  "lists_matchers": {
                    "str_lists_match": {
                      "list_ids": [
                        "string"
                      ]
                    },
                    "str_lists_not_match": {
                      "list_ids": [
                        "string"
                      ]
                    },
                    "reg_exp_lists_match": {
                      "list_ids": [
                        "string"
                      ]
                    },
                    "reg_exp_lists_not_match": {
                      "list_ids": [
                        "string"
                      ]
                    }
                  }
                  // end of the list of possible fields
                }
              }
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "source_ip": {
            "ip_ranges_match": {
              "ip_ranges": [
                "string"
              ]
            },
            "ip_ranges_not_match": {
              "ip_ranges": [
                "string"
              ]
            },
            "geo_ip_match": {
              "locations": [
                "string"
              ]
            },
            "geo_ip_not_match": {
              "locations": [
                "string"
              ]
            },
            "ip_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "ip_lists_not_match": {
              "list_ids": [
                "string"
              ]
            },
            "asn_ranges_match": {
              "asn_ranges": [
                "int64"
              ]
            },
            "asn_ranges_not_match": {
              "asn_ranges": [
                "int64"
              ]
            },
            "asn_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "asn_lists_not_match": {
              "list_ids": [
                "string"
              ]
            }
          },
          "cookies": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "bot_category": {
            "bot_category_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "bot_category_lists_not_match": {
              "list_ids": [
                "string"
              ]
            }
          },
          "bot_name": {
            "bot_name_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "bot_name_lists_not_match": {
              "list_ids": [
                "string"
              ]
            }
          },
          "bot_score": {
            "value": [
              {
                // Includes only one of the fields `le_match`, `ge_match`, `eq_match`, `ne_match`
                "le_match": {
                  "value": "int64"
                },
                "ge_match": {
                  "value": "int64"
                },
                "eq_match": {
                  "value": "int64"
                },
                "ne_match": {
                  "value": "int64"
                }
                // end of the list of possible fields
              }
            ]
          },
          "verified_bot": {
            "verified": {
              "match": "bool"
            }
          },
          "finger_print": {
            "ja3_ranges": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja4_ranges": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja3_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            },
            "ja4_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          }
        }
      },
      "smart_protection": {
        "mode": "Mode",
        "condition": {
          "authority": {
            "authorities": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "authority_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "http_method": {
            "http_methods": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "http_method_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "request_uri": {
            "path": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            },
            "queries": [
              {
                "key": "string",
                "value": {
                  // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                  "exact_match": "string",
                  "exact_not_match": "string",
                  "prefix_match": "string",
                  "prefix_not_match": "string",
                  "pire_regex_match": "string",
                  "pire_regex_not_match": "string",
                  "defined": "bool",
                  "lists_matchers": {
                    "str_lists_match": {
                      "list_ids": [
                        "string"
                      ]
                    },
                    "str_lists_not_match": {
                      "list_ids": [
                        "string"
                      ]
                    },
                    "reg_exp_lists_match": {
                      "list_ids": [
                        "string"
                      ]
                    },
                    "reg_exp_lists_not_match": {
                      "list_ids": [
                        "string"
                      ]
                    }
                  }
                  // end of the list of possible fields
                }
              }
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "source_ip": {
            "ip_ranges_match": {
              "ip_ranges": [
                "string"
              ]
            },
            "ip_ranges_not_match": {
              "ip_ranges": [
                "string"
              ]
            },
            "geo_ip_match": {
              "locations": [
                "string"
              ]
            },
            "geo_ip_not_match": {
              "locations": [
                "string"
              ]
            },
            "ip_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "ip_lists_not_match": {
              "list_ids": [
                "string"
              ]
            },
            "asn_ranges_match": {
              "asn_ranges": [
                "int64"
              ]
            },
            "asn_ranges_not_match": {
              "asn_ranges": [
                "int64"
              ]
            },
            "asn_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "asn_lists_not_match": {
              "list_ids": [
                "string"
              ]
            }
          },
          "cookies": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "bot_category": {
            "bot_category_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "bot_category_lists_not_match": {
              "list_ids": [
                "string"
              ]
            }
          },
          "bot_name": {
            "bot_name_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "bot_name_lists_not_match": {
              "list_ids": [
                "string"
              ]
            }
          },
          "bot_score": {
            "value": [
              {
                // Includes only one of the fields `le_match`, `ge_match`, `eq_match`, `ne_match`
                "le_match": {
                  "value": "int64"
                },
                "ge_match": {
                  "value": "int64"
                },
                "eq_match": {
                  "value": "int64"
                },
                "ne_match": {
                  "value": "int64"
                }
                // end of the list of possible fields
              }
            ]
          },
          "verified_bot": {
            "verified": {
              "match": "bool"
            }
          },
          "finger_print": {
            "ja3_ranges": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja4_ranges": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja3_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            },
            "ja4_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          }
        }
      },
      "waf": {
        "mode": "Mode",
        "condition": {
          "authority": {
            "authorities": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "authority_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "http_method": {
            "http_methods": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "http_method_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "request_uri": {
            "path": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            },
            "queries": [
              {
                "key": "string",
                "value": {
                  // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                  "exact_match": "string",
                  "exact_not_match": "string",
                  "prefix_match": "string",
                  "prefix_not_match": "string",
                  "pire_regex_match": "string",
                  "pire_regex_not_match": "string",
                  "defined": "bool",
                  "lists_matchers": {
                    "str_lists_match": {
                      "list_ids": [
                        "string"
                      ]
                    },
                    "str_lists_not_match": {
                      "list_ids": [
                        "string"
                      ]
                    },
                    "reg_exp_lists_match": {
                      "list_ids": [
                        "string"
                      ]
                    },
                    "reg_exp_lists_not_match": {
                      "list_ids": [
                        "string"
                      ]
                    }
                  }
                  // end of the list of possible fields
                }
              }
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "source_ip": {
            "ip_ranges_match": {
              "ip_ranges": [
                "string"
              ]
            },
            "ip_ranges_not_match": {
              "ip_ranges": [
                "string"
              ]
            },
            "geo_ip_match": {
              "locations": [
                "string"
              ]
            },
            "geo_ip_not_match": {
              "locations": [
                "string"
              ]
            },
            "ip_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "ip_lists_not_match": {
              "list_ids": [
                "string"
              ]
            },
            "asn_ranges_match": {
              "asn_ranges": [
                "int64"
              ]
            },
            "asn_ranges_not_match": {
              "asn_ranges": [
                "int64"
              ]
            },
            "asn_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "asn_lists_not_match": {
              "list_ids": [
                "string"
              ]
            }
          },
          "cookies": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "bot_category": {
            "bot_category_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "bot_category_lists_not_match": {
              "list_ids": [
                "string"
              ]
            }
          },
          "bot_name": {
            "bot_name_lists_match": {
              "list_ids": [
                "string"
              ]
            },
            "bot_name_lists_not_match": {
              "list_ids": [
                "string"
              ]
            }
          },
          "bot_score": {
            "value": [
              {
                // Includes only one of the fields `le_match`, `ge_match`, `eq_match`, `ne_match`
                "le_match": {
                  "value": "int64"
                },
                "ge_match": {
                  "value": "int64"
                },
                "eq_match": {
                  "value": "int64"
                },
                "ne_match": {
                  "value": "int64"
                }
                // end of the list of possible fields
              }
            ]
          },
          "verified_bot": {
            "verified": {
              "match": "bool"
            }
          },
          "finger_print": {
            "ja3_ranges": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja4_ranges": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string",
                "defined": "bool",
                "lists_matchers": {
                  "str_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "str_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_match": {
                    "list_ids": [
                      "string"
                    ]
                  },
                  "reg_exp_lists_not_match": {
                    "list_ids": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja3_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            },
            "ja4_matcher": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string",
              "defined": "bool",
              "lists_matchers": {
                "str_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "str_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_match": {
                  "list_ids": [
                    "string"
                  ]
                },
                "reg_exp_lists_not_match": {
                  "list_ids": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          }
        },
        "waf_profile_id": "string"
      },
      // end of the list of possible fields
      "name": "string",
      "priority": "int64",
      "dry_run": "bool",
      "description": "string",
      "custom_page_id": "string"
    }
  ],
  "captcha_id": "string",
  "advanced_rate_limiter_profile_id": "string",
  "disallow_data_processing": "bool",
  "analyze_request_body": {
    "size_limit": "int64",
    "size_limit_action": "Action"
  },
  "log_options": {
    "log_group_id": "string",
    "enable": "bool",
    "enabled_modules": [
      "Module"
    ],
    "enabled_actions": [
      "Action"
    ],
    "discard_allow_percentage": "int64",
    "outputs": [
      "Output"
    ]
  },
  "custom_page_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a security profile in. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| name | **string**

Required field. Name of the security profile. The name is unique within the folder. 1-50 characters long.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Optional description of the security profile. ||
|| default_action | enum **DefaultAction**

Action to perform if none of rules matched.

- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| security_rules[] | **[SecurityRule](#yandex.cloud.smartwebsecurity.v1.SecurityRule)**

List of security rules. ||
|| captcha_id | **string**

Captcha ID to use with this security profile. Set empty to use default. ||
|| advanced_rate_limiter_profile_id | **string**

Advanced rate limiter profile ID to use with this security profile. Set empty to use default. ||
|| disallow_data_processing | **bool**

Disables the use of HTTP request data for training and improving the service's ML models. ||
|| analyze_request_body | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody)**

Parameters for request body analyzer. ||
|| log_options | **[LogOptions](#yandex.cloud.smartwebsecurity.v1.SecurityProfile.LogOptions)**

Configures logging of requests processed by SWS to Audit Trails and Cloud Logging. ||
|| custom_page_id | **string**

ID of the default custom page shown to the user when a request is denied. ||
|#

## SecurityRule {#yandex.cloud.smartwebsecurity.v1.SecurityRule}

A SecurityRule object, see [Rules](/docs/smartwebsecurity/concepts/rules).

#|
||Field | Description ||
|| rule_condition | **[RuleCondition](#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition)**

Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action).

Includes only one of the fields `rule_condition`, `smart_protection`, `waf`. ||
|| smart_protection | **[SmartProtection](#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection)**

Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules).

Includes only one of the fields `rule_condition`, `smart_protection`, `waf`. ||
|| waf | **[Waf](#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf)**

Web Application Firewall (WAF) rule, see [WAF rules](/docs/smartwebsecurity/concepts/rules#waf-rules).

Includes only one of the fields `rule_condition`, `smart_protection`, `waf`. ||
|| name | **string**

Required field. Name of the rule. The name is unique within the security profile. 1-50 characters long.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| priority | **int64**

Determines the priority for checking the incoming traffic.
Enter an integer within the range of 1 and 999999.
The rule priority must be unique within the entire security profile.
A lower numeric value means a higher priority.
The default_action has the lowest priority.

Acceptable values are 1 to 999999, inclusive. ||
|| dry_run | **bool**

This mode allows you to test your security profile or a single rule.
For example, you can have the number of alarms for a specific rule displayed.
Note: if this option is true, no real action affecting your traffic regarding this rule will be taken. ||
|| description | **string**

Optional description of the rule. 0-512 characters long.

The maximum string length in characters is 512. ||
|| custom_page_id | **string**

ID of the custom page shown to the user when the rule denies a request. ||
|#

## RuleCondition {#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition}

RuleCondition object.

#|
||Field | Description ||
|| action | enum **Action**

Required field. Action to perform if this rule matched.

- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the rule. ||
|#

## Condition {#yandex.cloud.smartwebsecurity.v1.Condition}

Condition object. AND semantics implied.
See [documentation](/docs/smartwebsecurity/concepts/conditions) for matchers description.

#|
||Field | Description ||
|| authority | **[AuthorityMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher)**

Match authority (Host header). ||
|| http_method | **[HttpMethodMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher)**

Match HTTP method. ||
|| request_uri | **[RequestUriMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher)**

Match Request URI. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher)**

Match HTTP headers.

The maximum number of elements is 20. ||
|| source_ip | **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher)**

Match IP. ||
|| cookies[] | **[CookieMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.CookieMatcher)**

Match cookies.

The maximum number of elements is 20. ||
|| bot_category | **[BotCategoryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotCategoryMatcher)**

Match bot category. ||
|| bot_name | **[BotNameMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotNameMatcher)**

Match bot name. ||
|| bot_score | **[BotScoreMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotScoreMatcher)**

Match bot score. ||
|| verified_bot | **[VerifiedBotMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.VerifiedBotMatcher)**

Match verified bot. ||
|| finger_print | **[FingerPrintMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.FingerPrintMatcher)**

Match fingerprint. ||
|#

## AuthorityMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher}

AuthorityMatcher object.

#|
||Field | Description ||
|| authorities[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of authorities. OR semantics implied.

The maximum number of elements is 20. ||
|| authority_matcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Authority matcher. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher}

StringMatcher object.

#|
||Field | Description ||
|| exact_match | **string**

Exact match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`. ||
|| exact_not_match | **string**

Exact not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`. ||
|| prefix_match | **string**

Prefix match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`. ||
|| prefix_not_match | **string**

Prefix not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`. ||
|| pire_regex_match | **string**

PIRE regex match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`. ||
|| pire_regex_not_match | **string**

PIRE regex not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`. ||
|| defined | **bool**

Matches if the field is defined.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`. ||
|| lists_matchers | **[ListsMatchers](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatchers)**

Matches against string and regular expression lists.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`, `defined`, `lists_matchers`. ||
|#

## ListsMatchers {#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatchers}

ListsMatchers object.

#|
||Field | Description ||
|| str_lists_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

String lists to match with. ||
|| str_lists_not_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

String lists to not match with. ||
|| reg_exp_lists_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Regular expression lists to match with. ||
|| reg_exp_lists_not_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Regular expression lists to not match with. ||
|#

## ListsMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher}

ListsMatcher object.

#|
||Field | Description ||
|| list_ids[] | **string**

List of list IDs to match against. OR semantics implied.

The number of elements must be in the range 1-10. ||
|#

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher}

HttpMethodMatcher object.

#|
||Field | Description ||
|| http_methods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of HTTP methods. OR semantics implied.

The maximum number of elements is 20. ||
|| http_method_matcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

HTTP method matcher. ||
|#

## RequestUriMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher}

RequestUriMatcher object. AND semantics implied.

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). ||
|| queries[] | **[QueryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher)**

List of query matchers. AND semantics implied.

The maximum number of elements is 20. ||
|#

## QueryMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher}

QueryMatcher object.

#|
||Field | Description ||
|| key | **string**

Required field. Key of the query parameter.

The string length in characters must be 1-255. ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Required field. Value of the query parameter. ||
|#

## HeaderMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher}

HeaderMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of header (case insensitive).

The string length in characters must be 1-255. ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Required field. Value of the header. ||
|#

## IpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher}

IpMatcher object. AND semantics implied.

#|
||Field | Description ||
|| ip_ranges_match | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**

IP ranges to match with. ||
|| ip_ranges_not_match | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**

IP ranges to not match with. ||
|| geo_ip_match | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**

Geo locations to match with. ||
|| geo_ip_not_match | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**

Geo locations to not match with. ||
|| ip_lists_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

IP lists to match with. ||
|| ip_lists_not_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

IP lists to not match with. ||
|| asn_ranges_match | **[AsnRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AsnRangesMatcher)**

ASN ranges to match with. ||
|| asn_ranges_not_match | **[AsnRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AsnRangesMatcher)**

ASN ranges to not match with. ||
|| asn_lists_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

ASN lists to match with. ||
|| asn_lists_not_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

ASN lists to not match with. ||
|#

## IpRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher}

IpRangesMatcher object.

#|
||Field | Description ||
|| ip_ranges[] | **string**

List of IP ranges. OR semantics implied.

The string length in characters for each value must be greater than 0. The maximum number of elements is 10000. ||
|#

## GeoIpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied.

The minimum number of elements is 1. ||
|#

## AsnRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AsnRangesMatcher}

AsnRangesMatcher object.

#|
||Field | Description ||
|| asn_ranges[] | **int64**

List of ASN values to match against. OR semantics implied.

The maximum number of elements is 10000. Acceptable values are 0 to 4294967295, inclusive. ||
|#

## CookieMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.CookieMatcher}

CookieMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the cookie parametr.

The string length in characters must be 1-255. ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Required field. Value of the cookie parametr. ||
|#

## BotCategoryMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.BotCategoryMatcher}

BotCategoryMatcher object. AND semantics implied.

#|
||Field | Description ||
|| bot_category_lists_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot category lists to match with. ||
|| bot_category_lists_not_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot category lists to not match with. ||
|#

## BotNameMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.BotNameMatcher}

BotNameMatcher object. AND semantics implied.

#|
||Field | Description ||
|| bot_name_lists_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot name lists to match with. ||
|| bot_name_lists_not_match | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot name lists to not match with. ||
|#

## BotScoreMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.BotScoreMatcher}

BotScoreMatcher object.

#|
||Field | Description ||
|| value[] | **[IntMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntMatcher)**

List of integer matchers for bot score. OR semantics implied.

The maximum number of elements is 4. ||
|#

## IntMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntMatcher}

IntMatcher object.

#|
||Field | Description ||
|| le_match | **[IntLEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntLEMatcher)**

Less than or equal condition.

Includes only one of the fields `le_match`, `ge_match`, `eq_match`, `ne_match`. ||
|| ge_match | **[IntGEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntGEMatcher)**

Greater than or equal condition.

Includes only one of the fields `le_match`, `ge_match`, `eq_match`, `ne_match`. ||
|| eq_match | **[IntEQMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntEQMatcher)**

Equal condition.

Includes only one of the fields `le_match`, `ge_match`, `eq_match`, `ne_match`. ||
|| ne_match | **[IntNEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntNEMatcher)**

Not equal condition.

Includes only one of the fields `le_match`, `ge_match`, `eq_match`, `ne_match`. ||
|#

## IntLEMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntLEMatcher}

IntLEMatcher object.

#|
||Field | Description ||
|| value | **int64**

Upper bound value (inclusive). ||
|#

## IntGEMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntGEMatcher}

IntGEMatcher object.

#|
||Field | Description ||
|| value | **int64**

Lower bound value (inclusive). ||
|#

## IntEQMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntEQMatcher}

IntEQMatcher object.

#|
||Field | Description ||
|| value | **int64**

Value to match against. ||
|#

## IntNEMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntNEMatcher}

IntNEMatcher object.

#|
||Field | Description ||
|| value | **int64**

Value to not match against. ||
|#

## VerifiedBotMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.VerifiedBotMatcher}

VerifiedBotMatcher object.

#|
||Field | Description ||
|| verified | **[BoolMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BoolMatcher)**

Matches if the bot is verified or not. ||
|#

## BoolMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.BoolMatcher}

BoolMatcher object.

#|
||Field | Description ||
|| match | **bool**

Boolean value to match against. ||
|#

## FingerPrintMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.FingerPrintMatcher}

FingerPrintMatcher object.

#|
||Field | Description ||
|| ja3_ranges[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of JA3 fingerprint matchers. OR semantics implied.

The maximum number of elements is 20. ||
|| ja4_ranges[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of JA4 fingerprint matchers. OR semantics implied.

The maximum number of elements is 20. ||
|| ja3_matcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

JA3 fingerprint matcher. ||
|| ja4_matcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

JA4 fingerprint matcher. ||
|#

## SmartProtection {#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection}

SmartProtection object.

#|
||Field | Description ||
|| mode | enum **Mode**

Required field. Mode of protection.

- `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
with suspicious requests being sent to SmartCaptcha.
- `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
requests to SmartCaptcha. The suspicious requests will be blocked. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the rule. ||
|#

## Waf {#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf}

Waf object.

#|
||Field | Description ||
|| mode | enum **Mode**

Required field. Mode of protection.

- `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
with suspicious requests being sent to SmartCaptcha.
- `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
requests to SmartCaptcha. The suspicious requests will be blocked. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the rule. ||
|| waf_profile_id | **string**

Required field. ID of WAF profile to use in this rule. ||
|#

## AnalyzeRequestBody {#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody}

#|
||Field | Description ||
|| size_limit | **int64**

Maximum size of body to pass to analyzer. In kilobytes. ||
|| size_limit_action | enum **Action**

Required field. Action to perform if maximum size of body exceeded.

- `IGNORE`: Ignore body.
- `DENY`: Deny request. ||
|#

## LogOptions {#yandex.cloud.smartwebsecurity.v1.SecurityProfile.LogOptions}

#|
||Field | Description ||
|| log_group_id | **string**

ID of the Cloud Logging log group to write SWS logs to. ||
|| enable | **bool**

Enables logging of requests processed by SWS. ||
|| enabled_modules[] | enum **Module**

List of modules whose requests will be logged.

- `RULE_CONDITION`: Base rules condition check.
- `SMART_PROTECTION`: Smart Protection module.
- `WAF`: Web Application Firewall module.
- `ARL`: Advanced Rate Limiter module. ||
|| enabled_actions[] | enum **Action**

List of verdicts for which requests will be logged.

- `ALLOW`: Request was allowed.
- `DENY`: Request was denied.
- `CAPTCHA`: Request was redirected to CAPTCHA. ||
|| discard_allow_percentage | **int64**

Percentage of ALLOW verdicts to discard from logging (0-100).

Acceptable values are 0 to 100, inclusive. ||
|| outputs[] | enum **Output**

List of log destinations: Cloud Logging and/or Audit Trails.

- `CLOUD_LOGGING`: Write logs to Cloud Logging.
- `AUDIT_TRAILS`: Write logs to Audit Trails. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#