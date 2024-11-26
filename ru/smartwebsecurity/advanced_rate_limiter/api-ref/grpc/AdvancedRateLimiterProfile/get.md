---
editable: false
sourcePath: en/_api-ref-grpc/smartwebsecurity/v1/advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/get.md
---

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
  "labels": "string",
  "name": "string",
  "description": "string",
  "advanced_rate_limiter_rules": [
    {
      "name": "string",
      "priority": "int64",
      "description": "string",
      "dry_run": "bool",
      // Includes only one of the fields `static_quota`, `dynamic_quota`
      "static_quota": {
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
      }
      // end of the list of possible fields
    }
  ],
  "created_at": "google.protobuf.Timestamp",
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
|| labels | **string**

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| name | **string**

Required field. Name of the ARL profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the ARL profile. ||
|| advanced_rate_limiter_rules[] | **[AdvancedRateLimiterRule](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule)**

List of rules. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| cloud_id | **string**

ID of the cloud that the ARL profile belongs to. ||
|#

## AdvancedRateLimiterRule {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule}

A AdvancedRateLimiterRule object, see [Rules](/docs/smartwebsecurity/concepts/arl#traffic-conditions).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule. The name is unique within the ARL profile. 1-50 characters long. ||
|| priority | **int64**

Determines the priority in case there are several matched rules.
Enter an integer within the range of 1 and 999999.
The rule priority must be unique within the entire ARL profile.
A lower numeric value means a higher priority. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|| dry_run | **bool**

This allows you to evaluate backend capabilities and find the optimum limit values.
Requests will not be blocked in this mode. ||
|| static_quota | **[StaticQuota](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.StaticQuota)**

Static quota. Counting each request individually.

Includes only one of the fields `static_quota`, `dynamic_quota`. ||
|| dynamic_quota | **[DynamicQuota](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota)**

Dynamic quota. Grouping requests by a certain attribute and limiting the number of groups.

Includes only one of the fields `static_quota`, `dynamic_quota`. ||
|#

## StaticQuota {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.StaticQuota}

StaticQuota object.

#|
||Field | Description ||
|| action | enum **Action**

Action in case of exceeding this quota.

- `ACTION_UNSPECIFIED`
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the quota. ||
|| limit | **int64**

Desired maximum number of requests per period.
Enter an integer within the range of 1 and 9999999999999. ||
|| period | **int64**

Period of time in seconds. ||
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

## DynamicQuota {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota}

DynamicQuota object.

#|
||Field | Description ||
|| action | enum **Action**

Action in case of exceeding this quota.

- `ACTION_UNSPECIFIED`
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**

The condition for matching the quota. ||
|| limit | **int64**

Desired maximum number of requests per period.
Enter an integer within the range of 1 and 9999999999999. ||
|| period | **int64**

Period of time in seconds. ||
|| characteristics[] | **[Characteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic)**

List of characteristics. ||
|#

## Characteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic}

#|
||Field | Description ||
|| simple_characteristic | **[SimpleCharacteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.SimpleCharacteristic)**

Characteristic automatically based on the Request path, HTTP method, IP address, Region, and Host attributes.
See [Rules](/docs/smartwebsecurity/concepts/arl#requests-counting) for more details.

Includes only one of the fields `simple_characteristic`, `key_characteristic`. ||
|| key_characteristic | **[KeyCharacteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.KeyCharacteristic)**

Characteristic based on key match in the Query params, HTTP header, and HTTP cookie attributes.
See [Rules](/docs/smartwebsecurity/concepts/arl#requests-counting) for more details.

Includes only one of the fields `simple_characteristic`, `key_characteristic`. ||
|| case_insensitive | **bool**

Determines case-sensitive or case-insensitive keys matching. ||
|#

## SimpleCharacteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.SimpleCharacteristic}

#|
||Field | Description ||
|| type | enum **Type**

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
|| type | enum **Type**

Type of key characteristic.

- `TYPE_UNSPECIFIED`
- `COOKIE_KEY`: HTTP cookie key.
- `HEADER_KEY`: HTTP header key.
- `QUERY_KEY`: Query params key. ||
|| value | **string**

String value of the key. ||
|#