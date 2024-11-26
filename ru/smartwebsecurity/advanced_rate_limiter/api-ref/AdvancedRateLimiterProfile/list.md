---
editable: false
sourcePath: en/_api-ref/smartwebsecurity/v1/advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/list.md
---

# SmartWebSecurity ARL API, REST: AdvancedRateLimiterProfile.List

Retrieves the list of AdvancedRateLimiterProfile resources in the specified folder.

## HTTP request

```
GET https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/advancedRateLimiterProfiles
```

## Query parameters {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.ListAdvancedRateLimiterProfilesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder that the ARL profile belongs to.
Currently page_size, page_token, filter and order_by are not supported and List method will return all ARL profiles in the folder. ||
|#

## Response {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.ListAdvancedRateLimiterProfilesResponse}

**HTTP Code: 200 - OK**

```json
{
  "advancedRateLimiterProfiles": [
    {
      "id": "string",
      "folderId": "string",
      "labels": "string",
      "name": "string",
      "description": "string",
      "advancedRateLimiterRules": [
        {
          "name": "string",
          "priority": "string",
          "description": "string",
          "dryRun": "boolean",
          // Includes only one of the fields `staticQuota`, `dynamicQuota`
          "staticQuota": {
            "action": "string",
            "condition": {
              "authority": {
                "authorities": [
                  {
                    // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                    "exactMatch": "string",
                    "exactNotMatch": "string",
                    "prefixMatch": "string",
                    "prefixNotMatch": "string",
                    "pireRegexMatch": "string",
                    "pireRegexNotMatch": "string"
                    // end of the list of possible fields
                  }
                ]
              },
              "httpMethod": {
                "httpMethods": [
                  {
                    // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                    "exactMatch": "string",
                    "exactNotMatch": "string",
                    "prefixMatch": "string",
                    "prefixNotMatch": "string",
                    "pireRegexMatch": "string",
                    "pireRegexNotMatch": "string"
                    // end of the list of possible fields
                  }
                ]
              },
              "requestUri": {
                "path": {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                },
                "queries": [
                  {
                    "key": "string",
                    "value": {
                      // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                      "exactMatch": "string",
                      "exactNotMatch": "string",
                      "prefixMatch": "string",
                      "prefixNotMatch": "string",
                      "pireRegexMatch": "string",
                      "pireRegexNotMatch": "string"
                      // end of the list of possible fields
                    }
                  }
                ]
              },
              "headers": [
                {
                  "name": "string",
                  "value": {
                    // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                    "exactMatch": "string",
                    "exactNotMatch": "string",
                    "prefixMatch": "string",
                    "prefixNotMatch": "string",
                    "pireRegexMatch": "string",
                    "pireRegexNotMatch": "string"
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
                    // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                    "exactMatch": "string",
                    "exactNotMatch": "string",
                    "prefixMatch": "string",
                    "prefixNotMatch": "string",
                    "pireRegexMatch": "string",
                    "pireRegexNotMatch": "string"
                    // end of the list of possible fields
                  }
                ]
              },
              "httpMethod": {
                "httpMethods": [
                  {
                    // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                    "exactMatch": "string",
                    "exactNotMatch": "string",
                    "prefixMatch": "string",
                    "prefixNotMatch": "string",
                    "pireRegexMatch": "string",
                    "pireRegexNotMatch": "string"
                    // end of the list of possible fields
                  }
                ]
              },
              "requestUri": {
                "path": {
                  // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                  "exactMatch": "string",
                  "exactNotMatch": "string",
                  "prefixMatch": "string",
                  "prefixNotMatch": "string",
                  "pireRegexMatch": "string",
                  "pireRegexNotMatch": "string"
                  // end of the list of possible fields
                },
                "queries": [
                  {
                    "key": "string",
                    "value": {
                      // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                      "exactMatch": "string",
                      "exactNotMatch": "string",
                      "prefixMatch": "string",
                      "prefixNotMatch": "string",
                      "pireRegexMatch": "string",
                      "pireRegexNotMatch": "string"
                      // end of the list of possible fields
                    }
                  }
                ]
              },
              "headers": [
                {
                  "name": "string",
                  "value": {
                    // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
                    "exactMatch": "string",
                    "exactNotMatch": "string",
                    "prefixMatch": "string",
                    "prefixNotMatch": "string",
                    "pireRegexMatch": "string",
                    "pireRegexNotMatch": "string"
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
            ]
          }
          // end of the list of possible fields
        }
      ],
      "createdAt": "string",
      "cloudId": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| advancedRateLimiterProfiles[] | **[AdvancedRateLimiterProfile](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterProfile)**

List of AdvancedRateLimiterProfile resources.
Currently next_page_token is not supported and List method will return all ARL profiles in the folder. ||
|#

## AdvancedRateLimiterProfile {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterProfile}

A AdvancedRateLimiterProfile (ARL) resource.

#|
||Field | Description ||
|| id | **string**

ID of the ARL profile. ||
|| folderId | **string**

ID of the folder that the ARL profile belongs to. ||
|| labels | **string**

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| name | **string**

Required field. Name of the ARL profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the ARL profile. ||
|| advancedRateLimiterRules[] | **[AdvancedRateLimiterRule](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule)**

List of rules. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| cloudId | **string**

ID of the cloud that the ARL profile belongs to. ||
|#

## AdvancedRateLimiterRule {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule}

A AdvancedRateLimiterRule object, see [Rules](/docs/smartwebsecurity/concepts/arl#traffic-conditions).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule. The name is unique within the ARL profile. 1-50 characters long. ||
|| priority | **string** (int64)

Determines the priority in case there are several matched rules.
Enter an integer within the range of 1 and 999999.
The rule priority must be unique within the entire ARL profile.
A lower numeric value means a higher priority. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|| dryRun | **boolean**

This allows you to evaluate backend capabilities and find the optimum limit values.
Requests will not be blocked in this mode. ||
|| staticQuota | **[StaticQuota](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.StaticQuota)**

Static quota. Counting each request individually.

Includes only one of the fields `staticQuota`, `dynamicQuota`. ||
|| dynamicQuota | **[DynamicQuota](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota)**

Dynamic quota. Grouping requests by a certain attribute and limiting the number of groups.

Includes only one of the fields `staticQuota`, `dynamicQuota`. ||
|#

## StaticQuota {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.StaticQuota}

StaticQuota object.

#|
||Field | Description ||
|| action | **enum** (Action)

Action in case of exceeding this quota.

- `ACTION_UNSPECIFIED`
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the quota. ||
|| limit | **string** (int64)

Desired maximum number of requests per period.
Enter an integer within the range of 1 and 9999999999999. ||
|| period | **string** (int64)

Period of time in seconds. ||
|#

## Condition {#yandex.cloud.smartwebsecurity.v1.Condition}

Condition object. AND semantics implied.
See [documentation](/docs/smartwebsecurity/concepts/conditions) for matchers description.

#|
||Field | Description ||
|| authority | **[AuthorityMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher)**

Match authority (Host header). ||
|| httpMethod | **[HttpMethodMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher)**

Match HTTP method. ||
|| requestUri | **[RequestUriMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher)**

Match Request URI. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher)**

Match HTTP headers. ||
|| sourceIp | **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher)**

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
|| exactMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| exactNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexNotMatch | **string**

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|#

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher}

HttpMethodMatcher object.

#|
||Field | Description ||
|| httpMethods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**

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
|| ipRangesMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)** ||
|| ipRangesNotMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)** ||
|| geoIpMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)** ||
|| geoIpNotMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)** ||
|#

## IpRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher}

IpRangesMatcher object.

#|
||Field | Description ||
|| ipRanges[] | **string**

List of IP ranges. OR semantics implied. ||
|#

## GeoIpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied. ||
|#

## DynamicQuota {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota}

DynamicQuota object.

#|
||Field | Description ||
|| action | **enum** (Action)

Action in case of exceeding this quota.

- `ACTION_UNSPECIFIED`
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the quota. ||
|| limit | **string** (int64)

Desired maximum number of requests per period.
Enter an integer within the range of 1 and 9999999999999. ||
|| period | **string** (int64)

Period of time in seconds. ||
|| characteristics[] | **[Characteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic)**

List of characteristics. ||
|#

## Characteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic}

#|
||Field | Description ||
|| simpleCharacteristic | **[SimpleCharacteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.SimpleCharacteristic)**

Characteristic automatically based on the Request path, HTTP method, IP address, Region, and Host attributes.
See [Rules](/docs/smartwebsecurity/concepts/arl#requests-counting) for more details.

Includes only one of the fields `simpleCharacteristic`, `keyCharacteristic`. ||
|| keyCharacteristic | **[KeyCharacteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.KeyCharacteristic)**

Characteristic based on key match in the Query params, HTTP header, and HTTP cookie attributes.
See [Rules](/docs/smartwebsecurity/concepts/arl#requests-counting) for more details.

Includes only one of the fields `simpleCharacteristic`, `keyCharacteristic`. ||
|| caseInsensitive | **boolean**

Determines case-sensitive or case-insensitive keys matching. ||
|#

## SimpleCharacteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.SimpleCharacteristic}

#|
||Field | Description ||
|| type | **enum** (Type)

Type of simple characteristic.

- `TYPE_UNSPECIFIED`
- `REQUEST_PATH`: HTTP Request path.
- `HTTP_METHOD`: HTTP Method.
- `IP`: IP address.
- `GEO`: Region.
- `HOST`: Host. ||
|#

## KeyCharacteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.KeyCharacteristic}

#|
||Field | Description ||
|| type | **enum** (Type)

Type of key characteristic.

- `TYPE_UNSPECIFIED`
- `COOKIE_KEY`: HTTP cookie key.
- `HEADER_KEY`: HTTP header key.
- `QUERY_KEY`: Query params key. ||
|| value | **string**

String value of the key. ||
|#