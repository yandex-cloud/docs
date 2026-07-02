[Документация Yandex Cloud](../../../../../index.md) > [Yandex Smart Web Security](../../../../index.md) > Справочник API > gRPC (англ.) > [SmartWebSecurity ARL API](../index.md) > [AdvancedRateLimiterProfile](index.md) > Get

# SmartWebSecurity ARL API, gRPC: AdvancedRateLimiterProfileService.Get

Returns the specified AdvancedRateLimiterProfile resource.

## gRPC request

**rpc Get ([GetAdvancedRateLimiterProfileRequest](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.GetAdvancedRateLimiterProfileRequest)) returns ([AdvancedRateLimiterProfile](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterProfile))**

## GetAdvancedRateLimiterProfileRequest {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.GetAdvancedRateLimiterProfileRequest}

```json
{
  "advanced_rate_limiter_profile_id": "string"
}
```

#|
||Field | Description ||
|| advanced_rate_limiter_profile_id | **string**

Required field. ID of the AdvancedRateLimiterProfile resource to return. ||
|#

## AdvancedRateLimiterProfile {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterProfile}

```json
{
  "id": "string",
  "folder_id": "string",
  "labels": "map<string, string>",
  "name": "string",
  "description": "string",
  "advanced_rate_limiter_rules": [
    {
      // Includes only one of the fields `static_quota`, `dynamic_quota`
      "static_quota": {
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
        },
        "limit": "int64",
        "period": "int64"
      },
      "dynamic_quota": {
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
        },
        "limit": "int64",
        "period": "int64",
        "characteristics": [
          {
            // Includes only one of the fields `simple_characteristic`, `key_characteristic`
            "simple_characteristic": {
              "type": "Type"
            },
            "key_characteristic": {
              "type": "Type",
              "value": "string"
            },
            // end of the list of possible fields
            "case_insensitive": "bool"
          }
        ]
      },
      // end of the list of possible fields
      "name": "string",
      "priority": "int64",
      "description": "string",
      "dry_run": "bool"
    }
  ],
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "cloud_id": "string"
}
```

A AdvancedRateLimiterProfile (ARL) resource.

#|
||Field | Description ||
|| id | **string**

ID of the ARL profile. ||
|| folder_id | **string**

ID of the folder that the ARL profile belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| name | **string**

Name of the ARL profile. The name is unique within the folder. 1-50 characters long.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Optional description of the ARL profile.

The maximum string length in characters is 512. ||
|| advanced_rate_limiter_rules[] | **[AdvancedRateLimiterRule](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule)**

List of rules. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| cloud_id | **string**

ID of the cloud that the ARL profile belongs to. ||
|#

## AdvancedRateLimiterRule {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule}

A AdvancedRateLimiterRule object, see [Rules](../../../../concepts/arl.md#traffic-conditions).

#|
||Field | Description ||
|| static_quota | **[StaticQuota](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.StaticQuota)**

Static quota. Counting each request individually.

Includes only one of the fields `static_quota`, `dynamic_quota`. ||
|| dynamic_quota | **[DynamicQuota](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota)**

Dynamic quota. Grouping requests by a certain attribute and limiting the number of groups.

Includes only one of the fields `static_quota`, `dynamic_quota`. ||
|| name | **string**

Required field. Name of the rule. The name is unique within the ARL profile. 1-50 characters long.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| priority | **int64**

Determines the priority in case there are several matched rules.
Enter an integer within the range of 1 and 999999.
The rule priority must be unique within the entire ARL profile.
A lower numeric value means a higher priority.

Acceptable values are 1 to 999999, inclusive. ||
|| description | **string**

Optional description of the rule. 0-512 characters long.

The maximum string length in characters is 512. ||
|| dry_run | **bool**

This allows you to evaluate backend capabilities and find the optimum limit values.
Requests will not be blocked in this mode. ||
|#

## StaticQuota {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.StaticQuota}

StaticQuota object.

#|
||Field | Description ||
|| action | enum **Action**

Required field. Action in case of exceeding this quota.

- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the quota. ||
|| limit | **int64**

Desired maximum number of requests per period.
Enter an integer within the range of 1 and 9999999999999.

Acceptable values are 1 to 9999999999999, inclusive. ||
|| period | **int64**

Period of time in seconds. ||
|#

## Condition {#yandex.cloud.smartwebsecurity.v1.Condition}

Condition object. AND semantics implied.
See [documentation](../../../../concepts/conditions.md) for matchers description.

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

## DynamicQuota {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota}

DynamicQuota object.

#|
||Field | Description ||
|| action | enum **Action**

Required field. Action in case of exceeding this quota.

- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the quota. ||
|| limit | **int64**

Desired maximum number of requests per period.
Enter an integer within the range of 1 and 9999999999999.

Acceptable values are 1 to 9999999999999, inclusive. ||
|| period | **int64**

Period of time in seconds. ||
|| characteristics[] | **[Characteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic)**

List of characteristics.

The maximum number of elements is 3. ||
|#

## Characteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic}

#|
||Field | Description ||
|| simple_characteristic | **[SimpleCharacteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.SimpleCharacteristic)**

Characteristic automatically based on the Request path, HTTP method, IP address, Region, and Host attributes.
See [Rules](../../../../concepts/arl.md#requests-counting) for more details.

Includes only one of the fields `simple_characteristic`, `key_characteristic`. ||
|| key_characteristic | **[KeyCharacteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.KeyCharacteristic)**

Characteristic based on key match in the Query params, HTTP header, and HTTP cookie attributes.
See [Rules](../../../../concepts/arl.md#requests-counting) for more details.

Includes only one of the fields `simple_characteristic`, `key_characteristic`. ||
|| case_insensitive | **bool**

Determines case-sensitive or case-insensitive keys matching. ||
|#

## SimpleCharacteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.SimpleCharacteristic}

#|
||Field | Description ||
|| type | enum **Type**

Type of simple characteristic.

- `REQUEST_PATH`: HTTP Request path.
- `HTTP_METHOD`: HTTP Method.
- `IP`: IP address.
- `GEO`: Region.
- `HOST`: Host. ||
|#

## KeyCharacteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.KeyCharacteristic}

#|
||Field | Description ||
|| type | enum **Type**

Type of key characteristic.

- `COOKIE_KEY`: HTTP cookie key.
- `HEADER_KEY`: HTTP header key.
- `QUERY_KEY`: Query params key. ||
|| value | **string**

String value of the key. ||
|#