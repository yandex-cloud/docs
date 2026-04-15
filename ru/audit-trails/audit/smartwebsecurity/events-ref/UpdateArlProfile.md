---
editable: false
---

# Smart Web Security Audit Trails Events: UpdateArlProfile

## Event JSON schema {#yandex.cloud.audit.smartwebsecurity.UpdateArlProfile2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "advancedRateLimiterProfileId": "string",
    "advancedRateLimiterName": "string",
    "advancedRateLimiterRules": [
      {
        "name": "string",
        "priority": "string",
        "description": "string",
        "dryRun": "string",
        // Includes only one of the fields `staticQuota`, `dynamicQuota`
        "staticQuota": {
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
            "body": {
              "bodies": [
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
              "bodyMatcher": {
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
          "limit": "string",
          "period": "string"
        },
        "dynamicQuota": {
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
            "body": {
              "bodies": [
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
              "bodyMatcher": {
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
          "limit": "string",
          "period": "string",
          "characteristics": [
            {
              // Includes only one of the fields `simpleCharacteristic`, `keyCharacteristic`
              "simpleCharacteristic": {
                "type": "string"
              },
              "keyCharacteristic": {
                "type": "string",
                "value": "string"
              },
              // end of the list of possible fields
              "caseInsensitive": "boolean"
            }
          ],
          "banPeriod": "string"
        },
        // end of the list of possible fields
        "customPageId": "string"
      }
    ],
    "labels": "object",
    "description": "string",
    "customPageId": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.smartwebsecurity.UpdateArlProfile2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[ArlProfileDetails](#yandex.cloud.audit.smartwebsecurity.ArlProfileDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## ArlProfileDetails {#yandex.cloud.audit.smartwebsecurity.ArlProfileDetails}

#|
||Field | Description ||
|| advancedRateLimiterProfileId | **string** ||
|| advancedRateLimiterName | **string** ||
|| advancedRateLimiterRules[] | **[ArlRule](#yandex.cloud.audit.smartwebsecurity.ArlRule)** ||
|| labels | **object** (map<**string**, **string**>) ||
|| description | **string** ||
|| customPageId | **string** ||
|#

## ArlRule {#yandex.cloud.audit.smartwebsecurity.ArlRule}

#|
||Field | Description ||
|| name | **string** ||
|| priority | **string** (int64) ||
|| description | **string** ||
|| dryRun | **string** ||
|| staticQuota | **[StaticQuota](#yandex.cloud.audit.smartwebsecurity.ArlRule.StaticQuota)**

Includes only one of the fields `staticQuota`, `dynamicQuota`. ||
|| dynamicQuota | **[DynamicQuota](#yandex.cloud.audit.smartwebsecurity.ArlRule.DynamicQuota)**

Includes only one of the fields `staticQuota`, `dynamicQuota`. ||
|| customPageId | **string** ||
|#

## StaticQuota {#yandex.cloud.audit.smartwebsecurity.ArlRule.StaticQuota}

#|
||Field | Description ||
|| action | **enum** (Action)

- `DENY`
- `CAPTCHA` ||
|| condition | **[Condition](#yandex.cloud.audit.smartwebsecurity.Condition)** ||
|| limit | **string** (int64) ||
|| period | **string** (int64) ||
|#

## Condition {#yandex.cloud.audit.smartwebsecurity.Condition}

#|
||Field | Description ||
|| authority | **[AuthorityMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.AuthorityMatcher)** ||
|| httpMethod | **[HttpMethodMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.HttpMethodMatcher)** ||
|| requestUri | **[RequestUriMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.RequestUriMatcher)** ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.HeaderMatcher)** ||
|| sourceIp | **[IpMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.IpMatcher)** ||
|| body | **[BodyMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.BodyMatcher)** ||
|| cookies[] | **[CookieMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.CookieMatcher)** ||
|| botCategory | **[BotCategoryMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.BotCategoryMatcher)** ||
|| botName | **[BotNameMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.BotNameMatcher)** ||
|| botScore | **[BotScoreMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.BotScoreMatcher)** ||
|| verifiedBot | **[VerifiedBotMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.VerifiedBotMatcher)** ||
|| fingerPrint | **[FingerPrintMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.FingerPrintMatcher)** ||
|#

## AuthorityMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.AuthorityMatcher}

#|
||Field | Description ||
|| authorities[] | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|| authorityMatcher | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|#

## StringMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher}

#|
||Field | Description ||
|| exactMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| exactNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| prefixMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| prefixNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| pireRegexMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| pireRegexNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| defined | **boolean**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|| listsMatchers | **[ListsMatchers](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatchers)**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`, `defined`, `listsMatchers`. ||
|#

## ListsMatchers {#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatchers}

#|
||Field | Description ||
|| strListsMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|| strListsNotMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|| regExpListsMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|| regExpListsNotMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|#

## ListsMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher}

#|
||Field | Description ||
|| listIds[] | **string** ||
|#

## HttpMethodMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.HttpMethodMatcher}

#|
||Field | Description ||
|| httpMethods[] | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|| httpMethodMatcher | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|#

## RequestUriMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.RequestUriMatcher}

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|| queries[] | **[QueryMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.QueryMatcher)** ||
|#

## QueryMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.QueryMatcher}

#|
||Field | Description ||
|| key | **string** ||
|| value | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|#

## HeaderMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.HeaderMatcher}

#|
||Field | Description ||
|| name | **string** ||
|| value | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|#

## IpMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.IpMatcher}

#|
||Field | Description ||
|| ipRangesMatch | **[IpRangesMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.IpRangesMatcher)** ||
|| ipRangesNotMatch | **[IpRangesMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.IpRangesMatcher)** ||
|| geoIpMatch | **[GeoIpMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.GeoIpMatcher)** ||
|| geoIpNotMatch | **[GeoIpMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.GeoIpMatcher)** ||
|| ipListsMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|| ipListsNotMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|| asnRangesMatch | **[AsnRangesMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.AsnRangesMatcher)** ||
|| asnRangesNotMatch | **[AsnRangesMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.AsnRangesMatcher)** ||
|| asnListsMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|| asnListsNotMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|#

## IpRangesMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.IpRangesMatcher}

#|
||Field | Description ||
|| ipRanges[] | **string** ||
|#

## GeoIpMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.GeoIpMatcher}

#|
||Field | Description ||
|| locations[] | **string** ||
|#

## AsnRangesMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.AsnRangesMatcher}

#|
||Field | Description ||
|| asnRanges[] | **string** (int64) ||
|#

## BodyMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.BodyMatcher}

#|
||Field | Description ||
|| bodies[] | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|| bodyMatcher | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|#

## CookieMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.CookieMatcher}

#|
||Field | Description ||
|| name | **string** ||
|| value | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|#

## BotCategoryMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.BotCategoryMatcher}

#|
||Field | Description ||
|| botCategoryListsMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|| botCategoryListsNotMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|#

## BotNameMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.BotNameMatcher}

#|
||Field | Description ||
|| botNameListsMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|| botNameListsNotMatch | **[ListsMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.ListsMatcher)** ||
|#

## BotScoreMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.BotScoreMatcher}

#|
||Field | Description ||
|| value[] | **[IntMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.IntMatcher)** ||
|#

## IntMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.IntMatcher}

#|
||Field | Description ||
|| leMatch | **[IntLEMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.IntLEMatcher)**

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|| geMatch | **[IntGEMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.IntGEMatcher)**

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|| eqMatch | **[IntEQMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.IntEQMatcher)**

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|| neMatch | **[IntNEMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.IntNEMatcher)**

Includes only one of the fields `leMatch`, `geMatch`, `eqMatch`, `neMatch`. ||
|#

## IntLEMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.IntLEMatcher}

#|
||Field | Description ||
|| value | **string** (int64) ||
|#

## IntGEMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.IntGEMatcher}

#|
||Field | Description ||
|| value | **string** (int64) ||
|#

## IntEQMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.IntEQMatcher}

#|
||Field | Description ||
|| value | **string** (int64) ||
|#

## IntNEMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.IntNEMatcher}

#|
||Field | Description ||
|| value | **string** (int64) ||
|#

## VerifiedBotMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.VerifiedBotMatcher}

#|
||Field | Description ||
|| verified | **[BoolMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.BoolMatcher)** ||
|#

## BoolMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.BoolMatcher}

#|
||Field | Description ||
|| match | **boolean** ||
|#

## FingerPrintMatcher {#yandex.cloud.audit.smartwebsecurity.Condition.FingerPrintMatcher}

#|
||Field | Description ||
|| ja3Ranges[] | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|| ja4Ranges[] | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|| ja3Matcher | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|| ja4Matcher | **[StringMatcher](#yandex.cloud.audit.smartwebsecurity.Condition.StringMatcher)** ||
|#

## DynamicQuota {#yandex.cloud.audit.smartwebsecurity.ArlRule.DynamicQuota}

#|
||Field | Description ||
|| action | **enum** (Action)

- `DENY`
- `CAPTCHA` ||
|| condition | **[Condition](#yandex.cloud.audit.smartwebsecurity.Condition)** ||
|| limit | **string** (int64) ||
|| period | **string** (int64) ||
|| characteristics[] | **[Characteristic](#yandex.cloud.audit.smartwebsecurity.ArlRule.DynamicQuota.Characteristic)** ||
|| banPeriod | **string** (int64) ||
|#

## Characteristic {#yandex.cloud.audit.smartwebsecurity.ArlRule.DynamicQuota.Characteristic}

#|
||Field | Description ||
|| simpleCharacteristic | **[SimpleCharacteristic](#yandex.cloud.audit.smartwebsecurity.ArlRule.DynamicQuota.Characteristic.SimpleCharacteristic)**

Includes only one of the fields `simpleCharacteristic`, `keyCharacteristic`. ||
|| keyCharacteristic | **[KeyCharacteristic](#yandex.cloud.audit.smartwebsecurity.ArlRule.DynamicQuota.Characteristic.KeyCharacteristic)**

Includes only one of the fields `simpleCharacteristic`, `keyCharacteristic`. ||
|| caseInsensitive | **boolean** ||
|#

## SimpleCharacteristic {#yandex.cloud.audit.smartwebsecurity.ArlRule.DynamicQuota.Characteristic.SimpleCharacteristic}

#|
||Field | Description ||
|| type | **enum** (Type)

- `REQUEST_PATH`
- `HTTP_METHOD`
- `IP`
- `GEO`
- `HOST` ||
|#

## KeyCharacteristic {#yandex.cloud.audit.smartwebsecurity.ArlRule.DynamicQuota.Characteristic.KeyCharacteristic}

#|
||Field | Description ||
|| type | **enum** (Type)

- `COOKIE_KEY`
- `HEADER_KEY`
- `QUERY_KEY` ||
|| value | **string** ||
|#