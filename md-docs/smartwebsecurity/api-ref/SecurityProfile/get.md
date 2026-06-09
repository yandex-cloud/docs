# SmartWebSecurity API, REST: SecurityProfile.Get

Returns the specified SecurityProfile resource.

## HTTP request

```
GET https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/securityProfiles/{securityProfileId}
```

## Path parameters

#|
||Field | Description ||
|| securityProfileId | **string**

Required field. ID of the SecurityProfile resource to return. ||
|#

## Response {#yandex.cloud.smartwebsecurity.v1.SecurityProfile}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "labels": "object",
  "name": "string",
  "description": "string",
  "defaultAction": "string",
  "securityRules": [
    {
      // Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`
      "ruleCondition": {
        "action": "string",
        "condition": {
          "authority": {
            "authorities": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "authorityMatcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "httpMethod": {
            "httpMethods": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "httpMethodMatcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "requestUri": {
            "path": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
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
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string",
                  "defined": "boolean",
                  "listsMatchers": {
                    "strListsMatch": {
                      "listIds": [
                        "string"
                      ]
                    },
                    "strListsNotMatch": {
                      "listIds": [
                        "string"
                      ]
                    },
                    "regExpListsMatch": {
                      "listIds": [
                        "string"
                      ]
                    },
                    "regExpListsNotMatch": {
                      "listIds": [
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
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "sourceIp": {
            "ipRangesMatch": {
              "ipRanges": [
                "string"
              ]
            },
            "ipRangesNotMatch": {
              "ipRanges": [
                "string"
              ]
            },
            "geoIpMatch": {
              "locations": [
                "string"
              ]
            },
            "geoIpNotMatch": {
              "locations": [
                "string"
              ]
            },
            "ipListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "ipListsNotMatch": {
              "listIds": [
                "string"
              ]
            },
            "asnRangesMatch": {
              "asnRanges": [
                "string"
              ]
            },
            "asnRangesNotMatch": {
              "asnRanges": [
                "string"
              ]
            },
            "asnListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "asnListsNotMatch": {
              "listIds": [
                "string"
              ]
            }
          },
          "cookies": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "botCategory": {
            "botCategoryListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "botCategoryListsNotMatch": {
              "listIds": [
                "string"
              ]
            }
          },
          "botName": {
            "botNameListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "botNameListsNotMatch": {
              "listIds": [
                "string"
              ]
            }
          },
          "botScore": {
            "value": [
              {
                // Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`
                "leMatch": {
                  "value": "string"
                },
                "geMatch": {
                  "value": "string"
                },
                "eqMatch": {
                  "value": "string"
                },
                "neMatch": {
                  "value": "string"
                }
                // end of the list of possible fields
              }
            ]
          },
          "verifiedBot": {
            "verified": {
              "match": "boolean"
            }
          },
          "fingerPrint": {
            "ja3Ranges": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja4Ranges": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja3Matcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            },
            "ja4Matcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          }
        }
      },
      "smartProtection": {
        "mode": "string",
        "condition": {
          "authority": {
            "authorities": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "authorityMatcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "httpMethod": {
            "httpMethods": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "httpMethodMatcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "requestUri": {
            "path": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
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
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string",
                  "defined": "boolean",
                  "listsMatchers": {
                    "strListsMatch": {
                      "listIds": [
                        "string"
                      ]
                    },
                    "strListsNotMatch": {
                      "listIds": [
                        "string"
                      ]
                    },
                    "regExpListsMatch": {
                      "listIds": [
                        "string"
                      ]
                    },
                    "regExpListsNotMatch": {
                      "listIds": [
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
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "sourceIp": {
            "ipRangesMatch": {
              "ipRanges": [
                "string"
              ]
            },
            "ipRangesNotMatch": {
              "ipRanges": [
                "string"
              ]
            },
            "geoIpMatch": {
              "locations": [
                "string"
              ]
            },
            "geoIpNotMatch": {
              "locations": [
                "string"
              ]
            },
            "ipListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "ipListsNotMatch": {
              "listIds": [
                "string"
              ]
            },
            "asnRangesMatch": {
              "asnRanges": [
                "string"
              ]
            },
            "asnRangesNotMatch": {
              "asnRanges": [
                "string"
              ]
            },
            "asnListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "asnListsNotMatch": {
              "listIds": [
                "string"
              ]
            }
          },
          "cookies": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "botCategory": {
            "botCategoryListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "botCategoryListsNotMatch": {
              "listIds": [
                "string"
              ]
            }
          },
          "botName": {
            "botNameListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "botNameListsNotMatch": {
              "listIds": [
                "string"
              ]
            }
          },
          "botScore": {
            "value": [
              {
                // Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`
                "leMatch": {
                  "value": "string"
                },
                "geMatch": {
                  "value": "string"
                },
                "eqMatch": {
                  "value": "string"
                },
                "neMatch": {
                  "value": "string"
                }
                // end of the list of possible fields
              }
            ]
          },
          "verifiedBot": {
            "verified": {
              "match": "boolean"
            }
          },
          "fingerPrint": {
            "ja3Ranges": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja4Ranges": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja3Matcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            },
            "ja4Matcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
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
        "mode": "string",
        "condition": {
          "authority": {
            "authorities": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "authorityMatcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "httpMethod": {
            "httpMethods": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "httpMethodMatcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          },
          "requestUri": {
            "path": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
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
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string",
                  "defined": "boolean",
                  "listsMatchers": {
                    "strListsMatch": {
                      "listIds": [
                        "string"
                      ]
                    },
                    "strListsNotMatch": {
                      "listIds": [
                        "string"
                      ]
                    },
                    "regExpListsMatch": {
                      "listIds": [
                        "string"
                      ]
                    },
                    "regExpListsNotMatch": {
                      "listIds": [
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
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "sourceIp": {
            "ipRangesMatch": {
              "ipRanges": [
                "string"
              ]
            },
            "ipRangesNotMatch": {
              "ipRanges": [
                "string"
              ]
            },
            "geoIpMatch": {
              "locations": [
                "string"
              ]
            },
            "geoIpNotMatch": {
              "locations": [
                "string"
              ]
            },
            "ipListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "ipListsNotMatch": {
              "listIds": [
                "string"
              ]
            },
            "asnRangesMatch": {
              "asnRanges": [
                "string"
              ]
            },
            "asnRangesNotMatch": {
              "asnRanges": [
                "string"
              ]
            },
            "asnListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "asnListsNotMatch": {
              "listIds": [
                "string"
              ]
            }
          },
          "cookies": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            }
          ],
          "botCategory": {
            "botCategoryListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "botCategoryListsNotMatch": {
              "listIds": [
                "string"
              ]
            }
          },
          "botName": {
            "botNameListsMatch": {
              "listIds": [
                "string"
              ]
            },
            "botNameListsNotMatch": {
              "listIds": [
                "string"
              ]
            }
          },
          "botScore": {
            "value": [
              {
                // Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`
                "leMatch": {
                  "value": "string"
                },
                "geMatch": {
                  "value": "string"
                },
                "eqMatch": {
                  "value": "string"
                },
                "neMatch": {
                  "value": "string"
                }
                // end of the list of possible fields
              }
            ]
          },
          "verifiedBot": {
            "verified": {
              "match": "boolean"
            }
          },
          "fingerPrint": {
            "ja3Ranges": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja4Ranges": [
              {
                // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
                "exactMatch": "string",
                "exactNotMatch": "string",
                "prefixMatch": "string",
                "prefixNotMatch": "string",
                "pireRegexMatch": "string",
                "pireRegexNotMatch": "string",
                "defined": "boolean",
                "listsMatchers": {
                  "strListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "strListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsMatch": {
                    "listIds": [
                      "string"
                    ]
                  },
                  "regExpListsNotMatch": {
                    "listIds": [
                      "string"
                    ]
                  }
                }
                // end of the list of possible fields
              }
            ],
            "ja3Matcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            },
            "ja4Matcher": {
              // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`
              "exactMatch": "string",
              "exactNotMatch": "string",
              "prefixMatch": "string",
              "prefixNotMatch": "string",
              "pireRegexMatch": "string",
              "pireRegexNotMatch": "string",
              "defined": "boolean",
              "listsMatchers": {
                "strListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "strListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsMatch": {
                  "listIds": [
                    "string"
                  ]
                },
                "regExpListsNotMatch": {
                  "listIds": [
                    "string"
                  ]
                }
              }
              // end of the list of possible fields
            }
          }
        },
        "wafProfileId": "string"
      },
      // end of the list of possible fields
      "name": "string",
      "priority": "string",
      "dryRun": "boolean",
      "description": "string",
      "customPageId": "string"
    }
  ],
  "createdAt": "string",
  "cloudId": "string",
  "captchaId": "string",
  "advancedRateLimiterProfileId": "string",
  "disallowDataProcessing": "boolean",
  "analyzeRequestBody": {
    "sizeLimit": "string",
    "sizeLimitAction": "string"
  },
  "logOptions": {
    "logGroupId": "string",
    "enable": "boolean",
    "enabledModules": [
      "string"
    ],
    "enabledActions": [
      "string"
    ],
    "discardAllowPercentage": "string",
    "outputs": [
      "string"
    ]
  },
  "logGroupId": "string",
  "customPageId": "string"
}
```

A SecurityProfile resource.

#|
||Field | Description ||
|| id | **string**

ID of the security profile. ||
|| folderId | **string**

ID of the folder that the security profile belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| name | **string**

Name of the security profile. The name is unique within the folder. 1-50 characters long.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Optional description of the security profile.

The maximum string length in characters is 512. ||
|| defaultAction | **enum** (DefaultAction)

Required field. Action to perform if none of rules matched.

- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| securityRules[] | **[SecurityRule](#yandex.cloud.smartwebsecurity.v1.SecurityRule)**

List of security rules. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| cloudId | **string**

ID of the cloud that the security profile belongs to. ||
|| captchaId | **string**

Captcha ID to use with this security profile. Set empty to use default. ||
|| advancedRateLimiterProfileId | **string**

Advanced rate limiter profile ID to use with this security profile. Set empty to use default. ||
|| disallowDataProcessing | **boolean**

Disables the use of HTTP request data for training and improving the service's ML models. ||
|| analyzeRequestBody | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody)**

Parameters for request body analyzer. ||
|| logOptions | **[LogOptions](#yandex.cloud.smartwebsecurity.v1.SecurityProfile.LogOptions)**

Configures logging of requests processed by SWS to Audit Trails and Cloud Logging. ||
|| logGroupId | **string**

ID of the Cloud Logging log group to write SWS logs to. ||
|| customPageId | **string**

ID of the default custom page shown to the user when a request is denied. ||
|#

## SecurityRule {#yandex.cloud.smartwebsecurity.v1.SecurityRule}

A SecurityRule object, see [Rules](../../concepts/rules.md).

#|
||Field | Description ||
|| ruleCondition | **[RuleCondition](#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition)**

Rule actions, see [Rule actions](../../concepts/rules.md#rule-action).

Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`. ||
|| smartProtection | **[SmartProtection](#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection)**

Smart Protection rule, see [Smart Protection rules](../../concepts/rules.md#smart-protection-rules).

Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`. ||
|| waf | **[Waf](#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf)**

Web Application Firewall (WAF) rule, see [WAF rules](../../concepts/rules.md#waf-rules).

Includes only one of the fields `ruleCondition`, `smartProtection`, `waf`. ||
|| name | **string**

Required field. Name of the rule. The name is unique within the security profile. 1-50 characters long.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| priority | **string** (int64)

Determines the priority for checking the incoming traffic.
Enter an integer within the range of 1 and 999999.
The rule priority must be unique within the entire security profile.
A lower numeric value means a higher priority.
The default_action has the lowest priority.

Acceptable values are 1 to 999999, inclusive. ||
|| dryRun | **boolean**

This mode allows you to test your security profile or a single rule.
For example, you can have the number of alarms for a specific rule displayed.
Note: if this option is true, no real action affecting your traffic regarding this rule will be taken. ||
|| description | **string**

Optional description of the rule. 0-512 characters long.

The maximum string length in characters is 512. ||
|| customPageId | **string**

ID of the custom page shown to the user when the rule denies a request. ||
|#

## RuleCondition {#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition}

RuleCondition object.

#|
||Field | Description ||
|| action | **enum** (Action)

Required field. Action to perform if this rule matched.

- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the rule. ||
|#

## Condition {#yandex.cloud.smartwebsecurity.v1.Condition}

Condition object. AND semantics implied.
See [documentation](../../concepts/conditions.md) for matchers description.

#|
||Field | Description ||
|| authority | **[AuthorityMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher)**

Match authority (Host header). ||
|| httpMethod | **[HttpMethodMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher)**

Match HTTP method. ||
|| requestUri | **[RequestUriMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher)**

Match Request URI. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher)**

Match HTTP headers.

The maximum number of elements is 20. ||
|| sourceIp | **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher)**

Match IP. ||
|| cookies[] | **[CookieMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.CookieMatcher)**

Match cookies.

The maximum number of elements is 20. ||
|| botCategory | **[BotCategoryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotCategoryMatcher)**

Match bot category. ||
|| botName | **[BotNameMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotNameMatcher)**

Match bot name. ||
|| botScore | **[BotScoreMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.BotScoreMatcher)**

Match bot score. ||
|| verifiedBot | **[VerifiedBotMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.VerifiedBotMatcher)**

Match verified bot. ||
|| fingerPrint | **[FingerPrintMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.FingerPrintMatcher)**

Match fingerprint. ||
|#

## AuthorityMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher}

AuthorityMatcher object.

#|
||Field | Description ||
|| authorities[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of authorities. OR semantics implied.

The maximum number of elements is 20. ||
|| authorityMatcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Authority matcher. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher}

StringMatcher object.

#|
||Field | Description ||
|| exactMatch | **string**

Exact match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| exactNotMatch | **string**

Exact not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| prefixMatch | **string**

Prefix match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| prefixNotMatch | **string**

Prefix not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| pireRegexMatch | **string**

PIRE regex match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| pireRegexNotMatch | **string**

PIRE regex not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| defined | **boolean**

Matches if the field is defined.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| listsMatchers | **[ListsMatchers](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatchers)**

Matches against string and regular expression lists.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|#

## ListsMatchers {#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatchers}

ListsMatchers object.

#|
||Field | Description ||
|| strListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

String lists to match with. ||
|| strListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

String lists to not match with. ||
|| regExpListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Regular expression lists to match with. ||
|| regExpListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Regular expression lists to not match with. ||
|#

## ListsMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher}

ListsMatcher object.

#|
||Field | Description ||
|| listIds[] | **string**

List of list IDs to match against. OR semantics implied.

The number of elements must be in the range 1-10. ||
|#

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher}

HttpMethodMatcher object.

#|
||Field | Description ||
|| httpMethods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of HTTP methods. OR semantics implied.

The maximum number of elements is 20. ||
|| httpMethodMatcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

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
|| ipRangesMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**

IP ranges to match with. ||
|| ipRangesNotMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**

IP ranges to not match with. ||
|| geoIpMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**

Geo locations to match with. ||
|| geoIpNotMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**

Geo locations to not match with. ||
|| ipListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

IP lists to match with. ||
|| ipListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

IP lists to not match with. ||
|| asnRangesMatch | **[AsnRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AsnRangesMatcher)**

ASN ranges to match with. ||
|| asnRangesNotMatch | **[AsnRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AsnRangesMatcher)**

ASN ranges to not match with. ||
|| asnListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

ASN lists to match with. ||
|| asnListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

ASN lists to not match with. ||
|#

## IpRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher}

IpRangesMatcher object.

#|
||Field | Description ||
|| ipRanges[] | **string**

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
|| asnRanges[] | **string** (int64)

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
|| botCategoryListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot category lists to match with. ||
|| botCategoryListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot category lists to not match with. ||
|#

## BotNameMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.BotNameMatcher}

BotNameMatcher object. AND semantics implied.

#|
||Field | Description ||
|| botNameListsMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

Bot name lists to match with. ||
|| botNameListsNotMatch | **[ListsMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.ListsMatcher)**

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
|| leMatch | **[IntLEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntLEMatcher)**

Less than or equal condition.

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|| geMatch | **[IntGEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntGEMatcher)**

Greater than or equal condition.

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|| eqMatch | **[IntEQMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntEQMatcher)**

Equal condition.

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|| neMatch | **[IntNEMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IntNEMatcher)**

Not equal condition.

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|#

## IntLEMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntLEMatcher}

IntLEMatcher object.

#|
||Field | Description ||
|| value | **string** (int64)

Upper bound value (inclusive). ||
|#

## IntGEMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntGEMatcher}

IntGEMatcher object.

#|
||Field | Description ||
|| value | **string** (int64)

Lower bound value (inclusive). ||
|#

## IntEQMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntEQMatcher}

IntEQMatcher object.

#|
||Field | Description ||
|| value | **string** (int64)

Value to match against. ||
|#

## IntNEMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IntNEMatcher}

IntNEMatcher object.

#|
||Field | Description ||
|| value | **string** (int64)

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
|| match | **boolean**

Boolean value to match against. ||
|#

## FingerPrintMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.FingerPrintMatcher}

FingerPrintMatcher object.

#|
||Field | Description ||
|| ja3Ranges[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of JA3 fingerprint matchers. OR semantics implied.

The maximum number of elements is 20. ||
|| ja4Ranges[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of JA4 fingerprint matchers. OR semantics implied.

The maximum number of elements is 20. ||
|| ja3Matcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

JA3 fingerprint matcher. ||
|| ja4Matcher | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

JA4 fingerprint matcher. ||
|#

## SmartProtection {#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection}

SmartProtection object.

#|
||Field | Description ||
|| mode | **enum** (Mode)

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
|| mode | **enum** (Mode)

Required field. Mode of protection.

- `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
with suspicious requests being sent to SmartCaptcha.
- `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
requests to SmartCaptcha. The suspicious requests will be blocked. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the rule. ||
|| wafProfileId | **string**

Required field. ID of WAF profile to use in this rule. ||
|#

## AnalyzeRequestBody {#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody}

#|
||Field | Description ||
|| sizeLimit | **string** (int64)

Maximum size of body to pass to analyzer. In kilobytes. ||
|| sizeLimitAction | **enum** (Action)

Required field. Action to perform if maximum size of body exceeded.

- `IGNORE`: Ignore body.
- `DENY`: Deny request. ||
|#

## LogOptions {#yandex.cloud.smartwebsecurity.v1.SecurityProfile.LogOptions}

#|
||Field | Description ||
|| logGroupId | **string**

ID of the Cloud Logging log group to write SWS logs to. ||
|| enable | **boolean**

Enables logging of requests processed by SWS. ||
|| enabledModules[] | **enum** (Module)

List of modules whose requests will be logged.

- `RULE_CONDITION`: Base rules condition check.
- `SMART_PROTECTION`: Smart Protection module.
- `WAF`: Web Application Firewall module.
- `ARL`: Advanced Rate Limiter module. ||
|| enabledActions[] | **enum** (Action)

List of verdicts for which requests will be logged.

- `ALLOW`: Request was allowed.
- `DENY`: Request was denied.
- `CAPTCHA`: Request was redirected to CAPTCHA. ||
|| discardAllowPercentage | **string** (int64)

Percentage of ALLOW verdicts to discard from logging (0-100).

Acceptable values are 0 to 100, inclusive. ||
|| outputs[] | **enum** (Output)

List of log destinations: Cloud Logging and/or Audit Trails.

- `CLOUD_LOGGING`: Write logs to Cloud Logging.
- `AUDIT_TRAILS`: Write logs to Audit Trails. ||
|#