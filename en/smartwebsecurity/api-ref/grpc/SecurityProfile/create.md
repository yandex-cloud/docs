---
editable: false
sourcePath: en/_api-ref-grpc/smartwebsecurity/v1/api-ref/grpc/SecurityProfile/create.md
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
      "name": "string",
      "priority": "int64",
      "dry_run": "bool",
      // Includes only one of the fields `rule_condition`, `smart_protection`, `waf`
      "rule_condition": {
        "action": "Action",
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
        }
      },
      "smart_protection": {
        "mode": "Mode",
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
        }
      },
      "waf": {
        "mode": "Mode",
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
        "waf_profile_id": "string"
      },
      // end of the list of possible fields
      "description": "string"
    }
  ],
  "captcha_id": "string",
  "advanced_rate_limiter_profile_id": "string",
  "analyze_request_body": {
    "size_limit": "int64",
    "size_limit_action": "Action"
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a security profile in. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| name | **string**

Name of the security profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the security profile. ||
|| default_action | enum **DefaultAction**

Action to perform if none of rules matched.

- `DEFAULT_ACTION_UNSPECIFIED`
- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| security_rules[] | **[SecurityRule](#yandex.cloud.smartwebsecurity.v1.SecurityRule)**

List of security rules. ||
|| captcha_id | **string**

Captcha ID to use with this security profile. Set empty to use default. ||
|| advanced_rate_limiter_profile_id | **string**

Advanced rate limiter profile ID to use with this security profile. Set empty to use default. ||
|| analyze_request_body | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody)**

Parameters for request body analyzer. ||
|#

## SecurityRule {#yandex.cloud.smartwebsecurity.v1.SecurityRule}

A SecurityRule object, see [Rules](/docs/smartwebsecurity/concepts/rules).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule. The name is unique within the security profile. 1-50 characters long. ||
|| priority | **int64**

Determines the priority for checking the incoming traffic.
Enter an integer within the range of 1 and 999999.
The rule priority must be unique within the entire security profile.
A lower numeric value means a higher priority.
The default_action has the lowest priority. ||
|| dry_run | **bool**

This mode allows you to test your security profile or a single rule.
For example, you can have the number of alarms for a specific rule displayed.
Note: if this option is true, no real action affecting your traffic regarding this rule will be taken. ||
|| rule_condition | **[RuleCondition](#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition)**

Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action).

Includes only one of the fields `rule_condition`, `smart_protection`, `waf`. ||
|| smart_protection | **[SmartProtection](#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection)**

Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules).

Includes only one of the fields `rule_condition`, `smart_protection`, `waf`. ||
|| waf | **[Waf](#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf)**

Web Application Firewall (WAF) rule, see [WAF rules](/docs/smartwebsecurity/concepts/rules#waf-rules).

Includes only one of the fields `rule_condition`, `smart_protection`, `waf`. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|#

## RuleCondition {#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition}

RuleCondition object.

#|
||Field | Description ||
|| action | enum **Action**

Action to perform if this rule matched.

- `ACTION_UNSPECIFIED`
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

## SmartProtection {#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection}

SmartProtection object.

#|
||Field | Description ||
|| mode | enum **Mode**

Mode of protection.

- `MODE_UNSPECIFIED`
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

Mode of protection.

- `MODE_UNSPECIFIED`
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

Action to perform if maximum size of body exceeded.

- `ACTION_UNSPECIFIED`
- `IGNORE`: Ignore body.
- `DENY`: Deny request. ||
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
    "security_profile_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "labels": "map<string, string>",
    "name": "string",
    "description": "string",
    "default_action": "DefaultAction",
    "security_rules": [
      {
        "name": "string",
        "priority": "int64",
        "dry_run": "bool",
        // Includes only one of the fields `rule_condition`, `smart_protection`, `waf`
        "rule_condition": {
          "action": "Action",
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
          }
        },
        "smart_protection": {
          "mode": "Mode",
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
          }
        },
        "waf": {
          "mode": "Mode",
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
          "waf_profile_id": "string"
        },
        // end of the list of possible fields
        "description": "string"
      }
    ],
    "created_at": "google.protobuf.Timestamp",
    "cloud_id": "string",
    "captcha_id": "string",
    "advanced_rate_limiter_profile_id": "string",
    "analyze_request_body": {
      "size_limit": "int64",
      "size_limit_action": "Action"
    }
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
|| metadata | **[CreateSecurityProfileMetadata](#yandex.cloud.smartwebsecurity.v1.CreateSecurityProfileMetadata)**

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
|| response | **[SecurityProfile](#yandex.cloud.smartwebsecurity.v1.SecurityProfile)**

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

## CreateSecurityProfileMetadata {#yandex.cloud.smartwebsecurity.v1.CreateSecurityProfileMetadata}

#|
||Field | Description ||
|| security_profile_id | **string**

ID of the security profile that is being created. ||
|#

## SecurityProfile {#yandex.cloud.smartwebsecurity.v1.SecurityProfile}

A SecurityProfile resource.

#|
||Field | Description ||
|| id | **string**

ID of the security profile. ||
|| folder_id | **string**

ID of the folder that the security profile belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| name | **string**

Required field. Name of the security profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the security profile. ||
|| default_action | enum **DefaultAction**

Required field. Action to perform if none of rules matched.

- `DEFAULT_ACTION_UNSPECIFIED`
- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| security_rules[] | **[SecurityRule](#yandex.cloud.smartwebsecurity.v1.SecurityRule2)**

List of security rules. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| cloud_id | **string**

ID of the cloud that the security profile belongs to. ||
|| captcha_id | **string**

Captcha ID to use with this security profile. Set empty to use default. ||
|| advanced_rate_limiter_profile_id | **string**

Advanced rate limiter profile ID to use with this security profile. Set empty to use default. ||
|| analyze_request_body | **[AnalyzeRequestBody](#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody2)**

Parameters for request body analyzer. ||
|#

## SecurityRule {#yandex.cloud.smartwebsecurity.v1.SecurityRule2}

A SecurityRule object, see [Rules](/docs/smartwebsecurity/concepts/rules).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule. The name is unique within the security profile. 1-50 characters long. ||
|| priority | **int64**

Determines the priority for checking the incoming traffic.
Enter an integer within the range of 1 and 999999.
The rule priority must be unique within the entire security profile.
A lower numeric value means a higher priority.
The default_action has the lowest priority. ||
|| dry_run | **bool**

This mode allows you to test your security profile or a single rule.
For example, you can have the number of alarms for a specific rule displayed.
Note: if this option is true, no real action affecting your traffic regarding this rule will be taken. ||
|| rule_condition | **[RuleCondition](#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition2)**

Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action).

Includes only one of the fields `rule_condition`, `smart_protection`, `waf`. ||
|| smart_protection | **[SmartProtection](#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection2)**

Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules).

Includes only one of the fields `rule_condition`, `smart_protection`, `waf`. ||
|| waf | **[Waf](#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf2)**

Web Application Firewall (WAF) rule, see [WAF rules](/docs/smartwebsecurity/concepts/rules#waf-rules).

Includes only one of the fields `rule_condition`, `smart_protection`, `waf`. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|#

## RuleCondition {#yandex.cloud.smartwebsecurity.v1.SecurityRule.RuleCondition2}

RuleCondition object.

#|
||Field | Description ||
|| action | enum **Action**

Action to perform if this rule matched.

- `ACTION_UNSPECIFIED`
- `ALLOW`: Pass request to service.
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition2)**

The condition for matching the rule. ||
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

## SmartProtection {#yandex.cloud.smartwebsecurity.v1.SecurityRule.SmartProtection2}

SmartProtection object.

#|
||Field | Description ||
|| mode | enum **Mode**

Mode of protection.

- `MODE_UNSPECIFIED`
- `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
with suspicious requests being sent to SmartCaptcha.
- `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
requests to SmartCaptcha. The suspicious requests will be blocked. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition2)**

The condition for matching the rule. ||
|#

## Waf {#yandex.cloud.smartwebsecurity.v1.SecurityRule.Waf2}

Waf object.

#|
||Field | Description ||
|| mode | enum **Mode**

Mode of protection.

- `MODE_UNSPECIFIED`
- `FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis,
with suspicious requests being sent to SmartCaptcha.
- `API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious
requests to SmartCaptcha. The suspicious requests will be blocked. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition2)**

The condition for matching the rule. ||
|| waf_profile_id | **string**

Required field. ID of WAF profile to use in this rule. ||
|#

## AnalyzeRequestBody {#yandex.cloud.smartwebsecurity.v1.SecurityProfile.AnalyzeRequestBody2}

#|
||Field | Description ||
|| size_limit | **int64**

Maximum size of body to pass to analyzer. In kilobytes. ||
|| size_limit_action | enum **Action**

Action to perform if maximum size of body exceeded.

- `ACTION_UNSPECIFIED`
- `IGNORE`: Ignore body.
- `DENY`: Deny request. ||
|#