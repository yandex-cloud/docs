# SmartWebSecurity WAF API, gRPC: WafProfileService.Update

Updates the specified WAF profile.

## gRPC request

**rpc Update ([UpdateWafProfileRequest](#yandex.cloud.smartwebsecurity.v1.waf.UpdateWafProfileRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateWafProfileRequest {#yandex.cloud.smartwebsecurity.v1.waf.UpdateWafProfileRequest}

```json
{
  // Includes only one of the fields `core_rule_set`
  "core_rule_set": {
    "inbound_anomaly_score": "int64",
    "paranoia_level": "int64",
    "rule_set": {
      "name": "string",
      "version": "string",
      "type": "RuleSetType",
      "id": "string"
    }
  },
  // end of the list of possible fields
  "waf_profile_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "rules": [
    {
      "rule_id": "string",
      "is_enabled": "bool",
      "is_blocking": "bool"
    }
  ],
  "exclusion_rules": [
    {
      "name": "string",
      "description": "string",
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
      "exclude_rules": {
        "exclude_all": "bool",
        "rule_ids": [
          "string"
        ]
      },
      "log_excluded": "bool",
      "request_condition": {
        "param_matcher": {
          "param_names": [
            {
              "value": "string",
              "case_sensitive": "bool"
            }
          ]
        },
        "header_matcher": {
          "header_names": [
            {
              "value": "string",
              "case_sensitive": "bool"
            }
          ]
        },
        "cookie_matcher": {
          "cookie_names": [
            {
              "value": "string",
              "case_sensitive": "bool"
            }
          ]
        },
        "body_matcher": {
          "body_values": [
            {
              "value": "string",
              "case_sensitive": "bool"
            }
          ],
          "is_excluded": "bool"
        }
      }
    }
  ],
  "analyze_request_body": {
    "is_enabled": "bool",
    "size_limit": "int64",
    "size_limit_action": "Action"
  },
  "rule_sets": [
    {
      // Includes only one of the fields `core_rule_set`, `ya_rule_set`, `ml_rule_set`
      "core_rule_set": {
        "rule_set": {
          "name": "string",
          "version": "string",
          "type": "RuleSetType",
          "id": "string"
        },
        "inbound_anomaly_score": "int64",
        "paranoia_level": "int64"
      },
      "ya_rule_set": {
        "rule_set": {
          "name": "string",
          "version": "string",
          "type": "RuleSetType",
          "id": "string"
        },
        "rule_groups": [
          {
            "id": "string",
            "action": "Action",
            "inbound_anomaly_score": "int64",
            "is_enabled": "bool"
          }
        ]
      },
      "ml_rule_set": {
        "rule_set": {
          "name": "string",
          "version": "string",
          "type": "RuleSetType",
          "id": "string"
        },
        "rule_groups": [
          {
            "id": "string",
            "action": "Action",
            "inbound_anomaly_score": "int64",
            "is_enabled": "bool"
          }
        ]
      },
      // end of the list of possible fields
      "priority": "int64",
      "is_enabled": "bool",
      "action": "RuleSetAction"
    }
  ],
  "match_all_rule_sets": "bool"
}
```

#|
||Field | Description ||
|| core_rule_set | **[CoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet)**

Core rule set settings. See [Basic rule set](../../../../concepts/waf.md#rules-set) for details.

Includes only one of the fields `core_rule_set`. ||
|| waf_profile_id | **string**

Required field. ID of the WAF profile to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the WafProfile resource are going to be updated. ||
|| name | **string**

Name of the WAF profile. The name is unique within the folder. 1-50 characters long.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Optional description of the WAF profile. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| rules[] | **[WafProfileRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule)**

Settings for each rule in rule set. ||
|| exclusion_rules[] | **[WafProfileExclusionRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule)**

List of exclusion rules. See [Rules](../../../../concepts/waf.md#exclusion-rules). ||
|| analyze_request_body | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody)**

Parameters for request body analyzer. ||
|| rule_sets[] | **[WafProfileRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet)**

List of rule sets. See [Rules](../../../../concepts/waf.md#rules-set). ||
|| match_all_rule_sets | **bool**

Parameter determines should all rule sets be matched. ||
|#

## CoreRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet}

#|
||Field | Description ||
|| inbound_anomaly_score | **int64**

Anomaly score.
Enter an integer within the range of 2 and 10000.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [Rules](../../../../concepts/waf.md#anomaly) for more details.

Acceptable values are 2 to 10000, inclusive. ||
|| paranoia_level | **int64**

Paranoia level.
Enter an integer within the range of 1 and 4.
Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
but also the higher the probability of WAF false positives.
See [Rules](../../../../concepts/waf.md#paranoia) for more details.
NOTE: this option has no effect on enabling or disabling rules.
it is used only as recommendation for user to enable all rules with paranoia_level <= this value. ||
|| rule_set | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**

Required field. Rule set. ||
|#

## RuleSet {#yandex.cloud.smartwebsecurity.v1.waf.RuleSet}

A RuleSet object. Determines name and version of rule set.

#|
||Field | Description ||
|| name | **string**

Required field. Name of rule set. ||
|| version | **string**

Required field. Version of rule set. ||
|| type | enum **RuleSetType**

Type of rule set.

- `CORE`: Core rule set.
- `YA`: Yandex rule set.
- `ML`: Yandex machine learning rule set. ||
|| id | **string**

ID of rule set. ||
|#

## WafProfileRule {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule}

WafProfileRule object. Determines settings for each rule_id in rule set.

#|
||Field | Description ||
|| rule_id | **string**

Required field. Rule ID. ||
|| is_enabled | **bool**

Determines is it rule enabled or not. ||
|| is_blocking | **bool**

Determines is it rule blocking or not. ||
|#

## WafProfileExclusionRule {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule}

A WafProfileExclusionRule object. See [Exclusion rules](../../../../concepts/waf.md#exclusion-rules).

#|
||Field | Description ||
|| name | **string**

Required field. Name of exclusion rule. ||
|| description | **string**

Optional description of the rule. 0-512 characters long.

The maximum string length in characters is 512. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching traffic. ||
|| exclude_rules | **[ExcludeRules](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.ExcludeRules)**

Required field. Exclude rules. ||
|| log_excluded | **bool**

Records the fact that an exception rule is triggered. ||
|| request_condition | **[RequestCondition](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition)**

Additional condition applied to specific parts of the request to refine when the exclusion is triggered. ||
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

## ExcludeRules {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.ExcludeRules}

Determines list of excluded rules.

#|
||Field | Description ||
|| exclude_all | **bool**

Set this option true to exclude all rules. ||
|| rule_ids[] | **string**

List of rules to exclude. ||
|#

## RequestCondition {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition}

#|
||Field | Description ||
|| param_matcher | **[RequestParamMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.RequestParamMatcher)**

Matcher for request query parameters. ||
|| header_matcher | **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.HeaderMatcher)**

Matcher for request headers. ||
|| cookie_matcher | **[CookieMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.CookieMatcher)**

Matcher for request cookies. ||
|| body_matcher | **[BodyMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.BodyMatcher)**

Matcher for request body exclusion flag. ||
|#

## RequestParamMatcher {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.RequestParamMatcher}

#|
||Field | Description ||
|| param_names[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**

List of request query parameter names to match. Up to 20 entries.

The maximum number of elements is 20. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher}

#|
||Field | Description ||
|| value | **string**

String value to match against. ||
|| case_sensitive | **bool**

Whether the match is case sensitive. ||
|#

## HeaderMatcher {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.HeaderMatcher}

#|
||Field | Description ||
|| header_names[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**

List of request header names to match. Up to 20 entries.

The maximum number of elements is 20. ||
|#

## CookieMatcher {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.CookieMatcher}

#|
||Field | Description ||
|| cookie_names[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**

List of cookie names to match. Up to 20 entries.

The maximum number of elements is 20. ||
|#

## BodyMatcher {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.BodyMatcher}

#|
||Field | Description ||
|| body_values[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.RequestCondition.StringMatcher)**

Deprecated. Previously matched body content. Use is_excluded instead.

The maximum number of elements is 20. ||
|| is_excluded | **bool**

When true, request body is excluded from WAF inspection for this exclusion rule. ||
|#

## AnalyzeRequestBody {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody}

#|
||Field | Description ||
|| is_enabled | **bool**

Possible to turn analyzer on and turn if off. ||
|| size_limit | **int64**

Maximum size of body to pass to analyzer. In kilobytes. ||
|| size_limit_action | enum **Action**

Action to perform if maximum size of body exceeded.

- `IGNORE`: Ignore request.
- `DENY`: Deny request. ||
|#

## WafProfileRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet}

#|
||Field | Description ||
|| core_rule_set | **[WafProfileCoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileCoreRuleSet)**

Core rule set settings. See [Basic rule set](../../../../concepts/waf.md#rules-set) for details.

Includes only one of the fields `core_rule_set`, `ya_rule_set`, `ml_rule_set`. ||
|| ya_rule_set | **[WafProfileYaRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileYaRuleSet)**

Yandex rule set settings.

Includes only one of the fields `core_rule_set`, `ya_rule_set`, `ml_rule_set`. ||
|| ml_rule_set | **[WafProfileMlRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileMlRuleSet)**

Yandex Machine learning rule set settings.

Includes only one of the fields `core_rule_set`, `ya_rule_set`, `ml_rule_set`. ||
|| priority | **int64**

Priority of rule set.

Acceptable values are 1 to 999999, inclusive. ||
|| is_enabled | **bool**

Determines is it rule set enabled or not. ||
|| action | enum **RuleSetAction**

Action to perfome on rule set match.

- `DENY`: Deny request.
- `CAPTCHA`: Show captcha. ||
|#

## WafProfileCoreRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileCoreRuleSet}

#|
||Field | Description ||
|| rule_set | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**

Required field. Rule set. ||
|| inbound_anomaly_score | **int64**

Anomaly score.
Enter an integer within the range of 2 and 10000.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [Rules](../../../../concepts/waf.md#anomaly) for more details.

Acceptable values are 2 to 10000, inclusive. ||
|| paranoia_level | **int64**

Paranoia level.
Enter an integer within the range of 1 and 4.
Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
but also the higher the probability of WAF false positives.
See [Rules](../../../../concepts/waf.md#paranoia) for more details.
NOTE: this option has no effect on enabling or disabling rules.
it is used only as recommendation for user to enable all rules with paranoia_level <= this value. ||
|#

## WafProfileYaRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileYaRuleSet}

#|
||Field | Description ||
|| rule_set | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**

Required field. Rule set. ||
|| rule_groups[] | **[RuleGroup](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup)**

List of rule groups. ||
|#

## RuleGroup {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup}

#|
||Field | Description ||
|| id | **string**

ID of the rule group. ||
|| action | enum **Action**

Action to perfome on rule group match.

- `DENY`: Deny request.
- `LOG`: Log request.
- `IGNORE`: Ignore request. ||
|| inbound_anomaly_score | **int64**

Anomaly score.

Acceptable values are 1 to 10000, inclusive. ||
|| is_enabled | **bool**

Determines is it rule group enabled or not. ||
|#

## WafProfileMlRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileMlRuleSet}

#|
||Field | Description ||
|| rule_set | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet)**

Required field. Rule set. ||
|| rule_groups[] | **[RuleGroup](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup)**

List of rule groups. ||
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

An Operation resource. For more information, see [Operation](../../../../../api-design-guide/concepts/operation.md).

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