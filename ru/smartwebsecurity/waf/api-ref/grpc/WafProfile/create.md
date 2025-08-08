---
editable: false
sourcePath: en/_api-ref-grpc/smartwebsecurity/v1/waf/api-ref/grpc/WafProfile/create.md
---

# SmartWebSecurity WAF API, gRPC: WafProfileService.Create

Creates a WAF profile in the specified folder using the data specified in the request.

## gRPC request

**rpc Create ([CreateWafProfileRequest](#yandex.cloud.smartwebsecurity.v1.waf.CreateWafProfileRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateWafProfileRequest {#yandex.cloud.smartwebsecurity.v1.waf.CreateWafProfileRequest}

```json
{
  "folder_id": "string",
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
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string"
              // end of the list of possible fields
            }
          ]
        },
        "http_method": {
          "http_methods": [
            {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string"
              // end of the list of possible fields
            }
          ]
        },
        "request_uri": {
          "path": {
            // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
            "exact_match": "string",
            "exact_not_match": "string",
            "prefix_match": "string",
            "prefix_not_match": "string",
            "pire_regex_match": "string",
            "pire_regex_not_match": "string"
            // end of the list of possible fields
          },
          "queries": [
            {
              "key": "string",
              "value": {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string"
                // end of the list of possible fields
              }
            }
          ]
        },
        "headers": [
          {
            "name": "string",
            "value": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string"
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
          }
        }
      },
      "exclude_rules": {
        "exclude_all": "bool",
        "rule_ids": [
          "string"
        ]
      },
      "log_excluded": "bool"
    }
  ],
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
|| folder_id | **string**

ID of the folder to create a WAF profile in. ||
|| name | **string**

Name of the WAF profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the WAF profile. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| rules[] | **[WafProfileRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule)**

Settings for each rule in rule set. ||
|| exclusion_rules[] | **[WafProfileExclusionRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule)**

List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). ||
|| core_rule_set | **[CoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet)**

Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.

Includes only one of the fields `core_rule_set`. ||
|| analyze_request_body | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody)**

Parameters for request body analyzer. ||
|| rule_sets[] | **[WafProfileRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet)**

List of rule sets. See [Rules](/docs/smartwebsecurity/concepts/waf#rules-set). ||
|| match_all_rule_sets | **bool**

Parameter determines should all rule sets be matched. ||
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

A WafProfileExclusionRule object. See [Exclusion rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules).

#|
||Field | Description ||
|| name | **string**

Required field. Name of exclusion rule. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching traffic. ||
|| exclude_rules | **[ExcludeRules](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.ExcludeRules)**

Required field. Exclude rules. ||
|| log_excluded | **bool**

Records the fact that an exception rule is triggered. ||
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

Match HTTP headers. ||
|| source_ip | **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher)**

Match IP. ||
|#

## AuthorityMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher}

AuthorityMatcher object.

#|
||Field | Description ||
|| authorities[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of authorities. OR semantics implied. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher}

StringMatcher object.

#|
||Field | Description ||
|| exact_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| exact_not_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| prefix_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| prefix_not_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| pire_regex_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| pire_regex_not_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|#

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher}

HttpMethodMatcher object.

#|
||Field | Description ||
|| http_methods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

List of HTTP methods. OR semantics implied. ||
|#

## RequestUriMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher}

RequestUriMatcher object. AND semantics implied.

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). ||
|| queries[] | **[QueryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher)**

List of query matchers. AND semantics implied. ||
|#

## QueryMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher}

QueryMatcher object.

#|
||Field | Description ||
|| key | **string**

Required field. Key of the query parameter. ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Required field. Value of the query parameter. ||
|#

## HeaderMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher}

HeaderMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of header (case insensitive). ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

Required field. Value of the header. ||
|#

## IpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher}

IpMatcher object. AND semantics implied.

#|
||Field | Description ||
|| ip_ranges_match | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)** ||
|| ip_ranges_not_match | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)** ||
|| geo_ip_match | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)** ||
|| geo_ip_not_match | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)** ||
|#

## IpRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher}

IpRangesMatcher object.

#|
||Field | Description ||
|| ip_ranges[] | **string**

List of IP ranges. OR semantics implied. ||
|#

## GeoIpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied. ||
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

## CoreRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet}

#|
||Field | Description ||
|| inbound_anomaly_score | **int64**

Anomaly score.
Enter an integer within the range of 2 and 10000.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details. ||
|| paranoia_level | **int64**

Paranoia level.
Enter an integer within the range of 1 and 4.
Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
but also the higher the probability of WAF false positives.
See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
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

- `RULE_SET_TYPE_UNSPECIFIED`
- `CORE`: Core rule set.
- `YA`: Yandex rule set.
- `ML`: Yandex machine learning rule set. ||
|| id | **string**

ID of rule set. ||
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

- `ACTION_UNSPECIFIED`
- `IGNORE`: Ignore request.
- `DENY`: Deny request. ||
|#

## WafProfileRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet}

#|
||Field | Description ||
|| core_rule_set | **[WafProfileCoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileCoreRuleSet)**

Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.

Includes only one of the fields `core_rule_set`, `ya_rule_set`, `ml_rule_set`. ||
|| ya_rule_set | **[WafProfileYaRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileYaRuleSet)**

Yandex rule set settings.

Includes only one of the fields `core_rule_set`, `ya_rule_set`, `ml_rule_set`. ||
|| ml_rule_set | **[WafProfileMlRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileMlRuleSet)**

Yandex Machine learning rule set settings.

Includes only one of the fields `core_rule_set`, `ya_rule_set`, `ml_rule_set`. ||
|| priority | **int64**

Priority of rule set. ||
|| is_enabled | **bool**

Determines is it rule set enabled or not. ||
|| action | enum **RuleSetAction**

Action to perfome on rule set match.

- `RULE_SET_ACTION_UNSPECIFIED`
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
See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details. ||
|| paranoia_level | **int64**

Paranoia level.
Enter an integer within the range of 1 and 4.
Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
but also the higher the probability of WAF false positives.
See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
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

- `ACTION_UNSPECIFIED`
- `DENY`: Deny request.
- `LOG`: Log request.
- `IGNORE`: Ignore request. ||
|| inbound_anomaly_score | **int64**

Anomaly score. ||
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
  "metadata": {
    "waf_profile_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "cloud_id": "string",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "created_at": "google.protobuf.Timestamp",
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
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string"
                // end of the list of possible fields
              }
            ]
          },
          "http_method": {
            "http_methods": [
              {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string"
                // end of the list of possible fields
              }
            ]
          },
          "request_uri": {
            "path": {
              // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
              "exact_match": "string",
              "exact_not_match": "string",
              "prefix_match": "string",
              "prefix_not_match": "string",
              "pire_regex_match": "string",
              "pire_regex_not_match": "string"
              // end of the list of possible fields
            },
            "queries": [
              {
                "key": "string",
                "value": {
                  // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
                  "exact_match": "string",
                  "exact_not_match": "string",
                  "prefix_match": "string",
                  "prefix_not_match": "string",
                  "pire_regex_match": "string",
                  "pire_regex_not_match": "string"
                  // end of the list of possible fields
                }
              }
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {
                // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
                "exact_match": "string",
                "exact_not_match": "string",
                "prefix_match": "string",
                "prefix_not_match": "string",
                "pire_regex_match": "string",
                "pire_regex_not_match": "string"
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
            }
          }
        },
        "exclude_rules": {
          "exclude_all": "bool",
          "rule_ids": [
            "string"
          ]
        },
        "log_excluded": "bool"
      }
    ],
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
|| metadata | **[CreateWafProfileMetadata](#yandex.cloud.smartwebsecurity.v1.waf.CreateWafProfileMetadata)**

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
|| response | **[WafProfile](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile)**

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

## CreateWafProfileMetadata {#yandex.cloud.smartwebsecurity.v1.waf.CreateWafProfileMetadata}

#|
||Field | Description ||
|| waf_profile_id | **string**

ID of the WAF profile that is being created. ||
|#

## WafProfile {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the WAF profile. ||
|| folder_id | **string**

Required field. ID of the folder that the WAF profile belongs to. ||
|| cloud_id | **string**

Required field. ID of the cloud that the WAF profile belongs to. ||
|| name | **string**

Required field. Name of the WAF profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the WAF profile. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| rules[] | **[WafProfileRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule2)**

Settings for each rule in rule set. ||
|| exclusion_rules[] | **[WafProfileExclusionRule](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule2)**

List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). ||
|| core_rule_set | **[CoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet2)**

Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.

Includes only one of the fields `core_rule_set`. ||
|| analyze_request_body | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody2)**

The parameter is deprecated. Parameters for request body analyzer. ||
|| rule_sets[] | **[WafProfileRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet2)**

List of rule sets. ||
|| match_all_rule_sets | **bool**

Determines ||
|#

## WafProfileRule {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileRule2}

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

## WafProfileExclusionRule {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule2}

A WafProfileExclusionRule object. See [Exclusion rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules).

#|
||Field | Description ||
|| name | **string**

Required field. Name of exclusion rule. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition2)**

The condition for matching traffic. ||
|| exclude_rules | **[ExcludeRules](#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.ExcludeRules2)**

Required field. Exclude rules. ||
|| log_excluded | **bool**

Records the fact that an exception rule is triggered. ||
|#

## Condition {#yandex.cloud.smartwebsecurity.v1.Condition2}

Condition object. AND semantics implied.
See [documentation](/docs/smartwebsecurity/concepts/conditions) for matchers description.

#|
||Field | Description ||
|| authority | **[AuthorityMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher2)**

Match authority (Host header). ||
|| http_method | **[HttpMethodMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher2)**

Match HTTP method. ||
|| request_uri | **[RequestUriMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher2)**

Match Request URI. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher2)**

Match HTTP headers. ||
|| source_ip | **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher2)**

Match IP. ||
|#

## AuthorityMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher2}

AuthorityMatcher object.

#|
||Field | Description ||
|| authorities[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

List of authorities. OR semantics implied. ||
|#

## StringMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2}

StringMatcher object.

#|
||Field | Description ||
|| exact_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| exact_not_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| prefix_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| prefix_not_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| pire_regex_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| pire_regex_not_match | **string**

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|#

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher2}

HttpMethodMatcher object.

#|
||Field | Description ||
|| http_methods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

List of HTTP methods. OR semantics implied. ||
|#

## RequestUriMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher2}

RequestUriMatcher object. AND semantics implied.

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). ||
|| queries[] | **[QueryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher2)**

List of query matchers. AND semantics implied. ||
|#

## QueryMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher2}

QueryMatcher object.

#|
||Field | Description ||
|| key | **string**

Required field. Key of the query parameter. ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

Required field. Value of the query parameter. ||
|#

## HeaderMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher2}

HeaderMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of header (case insensitive). ||
|| value | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

Required field. Value of the header. ||
|#

## IpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher2}

IpMatcher object. AND semantics implied.

#|
||Field | Description ||
|| ip_ranges_match | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher2)** ||
|| ip_ranges_not_match | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher2)** ||
|| geo_ip_match | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher2)** ||
|| geo_ip_not_match | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher2)** ||
|#

## IpRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher2}

IpRangesMatcher object.

#|
||Field | Description ||
|| ip_ranges[] | **string**

List of IP ranges. OR semantics implied. ||
|#

## GeoIpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher2}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied. ||
|#

## ExcludeRules {#yandex.cloud.smartwebsecurity.v1.waf.WafProfileExclusionRule.ExcludeRules2}

Determines list of excluded rules.

#|
||Field | Description ||
|| exclude_all | **bool**

Set this option true to exclude all rules. ||
|| rule_ids[] | **string**

List of rules to exclude. ||
|#

## CoreRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.CoreRuleSet2}

#|
||Field | Description ||
|| inbound_anomaly_score | **int64**

Anomaly score.
Enter an integer within the range of 2 and 10000.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details. ||
|| paranoia_level | **int64**

Paranoia level.
Enter an integer within the range of 1 and 4.
Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
but also the higher the probability of WAF false positives.
See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
NOTE: this option has no effect on enabling or disabling rules.
it is used only as recommendation for user to enable all rules with paranoia_level <= this value. ||
|| rule_set | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet2)**

Required field. Rule set. ||
|#

## RuleSet {#yandex.cloud.smartwebsecurity.v1.waf.RuleSet2}

A RuleSet object. Determines name and version of rule set.

#|
||Field | Description ||
|| name | **string**

Required field. Name of rule set. ||
|| version | **string**

Required field. Version of rule set. ||
|| type | enum **RuleSetType**

Type of rule set.

- `RULE_SET_TYPE_UNSPECIFIED`
- `CORE`: Core rule set.
- `YA`: Yandex rule set.
- `ML`: Yandex machine learning rule set. ||
|| id | **string**

ID of rule set. ||
|#

## AnalyzeRequestBody {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.AnalyzeRequestBody2}

#|
||Field | Description ||
|| is_enabled | **bool**

Possible to turn analyzer on and turn if off. ||
|| size_limit | **int64**

Maximum size of body to pass to analyzer. In kilobytes. ||
|| size_limit_action | enum **Action**

Action to perform if maximum size of body exceeded.

- `ACTION_UNSPECIFIED`
- `IGNORE`: Ignore request.
- `DENY`: Deny request. ||
|#

## WafProfileRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet2}

#|
||Field | Description ||
|| core_rule_set | **[WafProfileCoreRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileCoreRuleSet2)**

Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details.

Includes only one of the fields `core_rule_set`, `ya_rule_set`, `ml_rule_set`. ||
|| ya_rule_set | **[WafProfileYaRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileYaRuleSet2)**

Yandex rule set settings.

Includes only one of the fields `core_rule_set`, `ya_rule_set`, `ml_rule_set`. ||
|| ml_rule_set | **[WafProfileMlRuleSet](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileMlRuleSet2)**

Yandex Machine learning rule set settings.

Includes only one of the fields `core_rule_set`, `ya_rule_set`, `ml_rule_set`. ||
|| priority | **int64**

Priority of rule set. ||
|| is_enabled | **bool**

Determines is it rule set enabled or not. ||
|| action | enum **RuleSetAction**

Action to perfome on rule set match.

- `RULE_SET_ACTION_UNSPECIFIED`
- `DENY`: Deny request.
- `CAPTCHA`: Show captcha. ||
|#

## WafProfileCoreRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileCoreRuleSet2}

#|
||Field | Description ||
|| rule_set | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet2)**

Required field. Rule set. ||
|| inbound_anomaly_score | **int64**

Anomaly score.
Enter an integer within the range of 2 and 10000.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details. ||
|| paranoia_level | **int64**

Paranoia level.
Enter an integer within the range of 1 and 4.
Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection,
but also the higher the probability of WAF false positives.
See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details.
NOTE: this option has no effect on enabling or disabling rules.
it is used only as recommendation for user to enable all rules with paranoia_level <= this value. ||
|#

## WafProfileYaRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileYaRuleSet2}

#|
||Field | Description ||
|| rule_set | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet2)**

Required field. Rule set. ||
|| rule_groups[] | **[RuleGroup](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup2)**

List of rule groups. ||
|#

## RuleGroup {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup2}

#|
||Field | Description ||
|| id | **string**

ID of the rule group. ||
|| action | enum **Action**

Action to perfome on rule group match.

- `ACTION_UNSPECIFIED`
- `DENY`: Deny request.
- `LOG`: Log request.
- `IGNORE`: Ignore request. ||
|| inbound_anomaly_score | **int64**

Anomaly score. ||
|| is_enabled | **bool**

Determines is it rule group enabled or not. ||
|#

## WafProfileMlRuleSet {#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.WafProfileMlRuleSet2}

#|
||Field | Description ||
|| rule_set | **[RuleSet](#yandex.cloud.smartwebsecurity.v1.waf.RuleSet2)**

Required field. Rule set. ||
|| rule_groups[] | **[RuleGroup](#yandex.cloud.smartwebsecurity.v1.waf.WafProfile.WafProfileRuleSet.RuleGroup2)**

List of rule groups. ||
|#