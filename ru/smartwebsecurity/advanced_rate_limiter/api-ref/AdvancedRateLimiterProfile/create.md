---
editable: false
apiPlayground:
  - url: https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/advancedRateLimiterProfiles
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create a ARL profile in.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Labels as `` key:value `` pairs. Maximum of 64 per resource.
          type: object
          additionalProperties:
            type: string
        name:
          description: |-
            **string**
            Name of the ARL profile. The name is unique within the folder. 1-50 characters long.
          type: string
        description:
          description: |-
            **string**
            Optional description of the ARL profile.
          type: string
        advancedRateLimiterRules:
          description: |-
            **[AdvancedRateLimiterRule](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule)**
            List of rules.
          type: array
          items:
            $ref: '#/definitions/AdvancedRateLimiterRule'
      required:
        - folderId
      additionalProperties: false
    definitions:
      StringMatcher:
        type: object
        properties:
          exactMatch:
            description: |-
              **string**
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
          exactNotMatch:
            description: |-
              **string**
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
          prefixMatch:
            description: |-
              **string**
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
          prefixNotMatch:
            description: |-
              **string**
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
          pireRegexMatch:
            description: |-
              **string**
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
          pireRegexNotMatch:
            description: |-
              **string**
              Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`.
            type: string
        oneOf:
          - required:
              - exactMatch
          - required:
              - exactNotMatch
          - required:
              - prefixMatch
          - required:
              - prefixNotMatch
          - required:
              - pireRegexMatch
          - required:
              - pireRegexNotMatch
      AuthorityMatcher:
        type: object
        properties:
          authorities:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              List of authorities. OR semantics implied.
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
      HttpMethodMatcher:
        type: object
        properties:
          httpMethods:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              List of HTTP methods. OR semantics implied.
            type: array
            items:
              $ref: '#/definitions/StringMatcher'
      QueryMatcher:
        type: object
        properties:
          key:
            description: |-
              **string**
              Required field. Key of the query parameter.
            type: string
          value:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              Required field. Value of the query parameter.
            $ref: '#/definitions/StringMatcher'
        required:
          - key
          - value
      RequestUriMatcher:
        type: object
        properties:
          path:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3).
            $ref: '#/definitions/StringMatcher'
          queries:
            description: |-
              **[QueryMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.QueryMatcher)**
              List of query matchers. AND semantics implied.
            type: array
            items:
              $ref: '#/definitions/QueryMatcher'
      HeaderMatcher:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of header (case insensitive).
            type: string
          value:
            description: |-
              **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher)**
              Required field. Value of the header.
            $ref: '#/definitions/StringMatcher'
        required:
          - name
          - value
      IpRangesMatcher:
        type: object
        properties:
          ipRanges:
            description: |-
              **string**
              List of IP ranges. OR semantics implied.
            type: array
            items:
              type: string
      GeoIpMatcher:
        type: object
        properties:
          locations:
            description: |-
              **string**
              ISO 3166-1 alpha 2. OR semantics implied.
            uniqueItems: true
            type: array
            items:
              type: string
      IpMatcher:
        type: object
        properties:
          ipRangesMatch:
            description: '**[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**'
            $ref: '#/definitions/IpRangesMatcher'
          ipRangesNotMatch:
            description: '**[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher)**'
            $ref: '#/definitions/IpRangesMatcher'
          geoIpMatch:
            description: '**[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**'
            $ref: '#/definitions/GeoIpMatcher'
          geoIpNotMatch:
            description: '**[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher)**'
            $ref: '#/definitions/GeoIpMatcher'
      Condition:
        type: object
        properties:
          authority:
            description: |-
              **[AuthorityMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher)**
              Match authority (Host header).
            $ref: '#/definitions/AuthorityMatcher'
          httpMethod:
            description: |-
              **[HttpMethodMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher)**
              Match HTTP method.
            $ref: '#/definitions/HttpMethodMatcher'
          requestUri:
            description: |-
              **[RequestUriMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher)**
              Match Request URI.
            $ref: '#/definitions/RequestUriMatcher'
          headers:
            description: |-
              **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher)**
              Match HTTP headers.
            type: array
            items:
              $ref: '#/definitions/HeaderMatcher'
          sourceIp:
            description: |-
              **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher)**
              Match IP.
            $ref: '#/definitions/IpMatcher'
      StaticQuota:
        type: object
        properties:
          action:
            description: |-
              **enum** (Action)
              Action in case of exceeding this quota.
              - `ACTION_UNSPECIFIED`
              - `DENY`: Deny request.
            type: string
            enum:
              - ACTION_UNSPECIFIED
              - DENY
          condition:
            description: |-
              **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**
              The condition for matching the quota.
            $ref: '#/definitions/Condition'
          limit:
            description: |-
              **string** (int64)
              Desired maximum number of requests per period.
              Enter an integer within the range of 1 and 9999999999999.
            type: string
            format: int64
          period:
            description: |-
              **string** (int64)
              Period of time in seconds.
            type: string
            format: int64
      SimpleCharacteristic:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Type of simple characteristic.
              - `TYPE_UNSPECIFIED`
              - `REQUEST_PATH`: HTTP Request path.
              - `HTTP_METHOD`: HTTP Method.
              - `IP`: IP address.
              - `GEO`: Region.
              - `HOST`: Host.
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - REQUEST_PATH
              - HTTP_METHOD
              - IP
              - GEO
              - HOST
      KeyCharacteristic:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Type of key characteristic.
              - `TYPE_UNSPECIFIED`
              - `REQUEST_PATH`: HTTP Request path.
              - `HTTP_METHOD`: HTTP Method.
              - `IP`: IP address.
              - `GEO`: Region.
              - `HOST`: Host.
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - REQUEST_PATH
              - HTTP_METHOD
              - IP
              - GEO
              - HOST
          value:
            description: |-
              **string**
              String value of the key.
            type: string
      Characteristic:
        type: object
        properties:
          simpleCharacteristic:
            description: |-
              **[SimpleCharacteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.SimpleCharacteristic)**
              Characteristic automatically based on the Request path, HTTP method, IP address, Region, and Host attributes.
              See [Rules](/docs/smartwebsecurity/concepts/arl#requests-counting) for more details.
              Includes only one of the fields `simpleCharacteristic`, `keyCharacteristic`.
            $ref: '#/definitions/SimpleCharacteristic'
          keyCharacteristic:
            description: |-
              **[KeyCharacteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.KeyCharacteristic)**
              Characteristic based on key match in the Query params, HTTP header, and HTTP cookie attributes.
              See [Rules](/docs/smartwebsecurity/concepts/arl#requests-counting) for more details.
              Includes only one of the fields `simpleCharacteristic`, `keyCharacteristic`.
            $ref: '#/definitions/KeyCharacteristic'
          caseInsensitive:
            description: |-
              **boolean**
              Determines case-sensitive or case-insensitive keys matching.
            type: boolean
        oneOf:
          - required:
              - simpleCharacteristic
          - required:
              - keyCharacteristic
      DynamicQuota:
        type: object
        properties:
          action:
            description: |-
              **enum** (Action)
              Action in case of exceeding this quota.
              - `ACTION_UNSPECIFIED`
              - `DENY`: Deny request.
            type: string
            enum:
              - ACTION_UNSPECIFIED
              - DENY
          condition:
            description: |-
              **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition)**
              The condition for matching the quota.
            $ref: '#/definitions/Condition'
          limit:
            description: |-
              **string** (int64)
              Desired maximum number of requests per period.
              Enter an integer within the range of 1 and 9999999999999.
            type: string
            format: int64
          period:
            description: |-
              **string** (int64)
              Period of time in seconds.
            type: string
            format: int64
          characteristics:
            description: |-
              **[Characteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic)**
              List of characteristics.
            type: array
            items:
              $ref: '#/definitions/Characteristic'
      AdvancedRateLimiterRule:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the rule. The name is unique within the ARL profile. 1-50 characters long.
            pattern: '[a-zA-Z0-9][a-zA-Z0-9-_.]*'
            type: string
          priority:
            description: |-
              **string** (int64)
              Determines the priority in case there are several matched rules.
              Enter an integer within the range of 1 and 999999.
              The rule priority must be unique within the entire ARL profile.
              A lower numeric value means a higher priority.
            type: string
            format: int64
          description:
            description: |-
              **string**
              Optional description of the rule. 0-512 characters long.
            type: string
          dryRun:
            description: |-
              **boolean**
              This allows you to evaluate backend capabilities and find the optimum limit values.
              Requests will not be blocked in this mode.
            type: boolean
          staticQuota:
            description: |-
              **[StaticQuota](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.StaticQuota)**
              Static quota. Counting each request individually.
              Includes only one of the fields `staticQuota`, `dynamicQuota`.
            $ref: '#/definitions/StaticQuota'
          dynamicQuota:
            description: |-
              **[DynamicQuota](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota)**
              Dynamic quota. Grouping requests by a certain attribute and limiting the number of groups.
              Includes only one of the fields `staticQuota`, `dynamicQuota`.
            $ref: '#/definitions/DynamicQuota'
        required:
          - name
        oneOf:
          - required:
              - staticQuota
          - required:
              - dynamicQuota
sourcePath: en/_api-ref/smartwebsecurity/v1/advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/create.md
---

# SmartWebSecurity ARL API, REST: AdvancedRateLimiterProfile.Create

Creates a ARL profile in the specified folder using the data specified in the request.

## HTTP request

```
POST https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/advancedRateLimiterProfiles
```

## Body parameters {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.CreateAdvancedRateLimiterProfileRequest}

```json
{
  "folderId": "string",
  "labels": "object",
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
  ]
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a ARL profile in. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| name | **string**

Name of the ARL profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the ARL profile. ||
|| advancedRateLimiterRules[] | **[AdvancedRateLimiterRule](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule)**

List of rules. ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "advancedRateLimiterProfileId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "labels": "object",
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateAdvancedRateLimiterProfileMetadata](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.CreateAdvancedRateLimiterProfileMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[AdvancedRateLimiterProfile](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterProfile)**

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

## CreateAdvancedRateLimiterProfileMetadata {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.CreateAdvancedRateLimiterProfileMetadata}

#|
||Field | Description ||
|| advancedRateLimiterProfileId | **string**

ID of the ARL profile that is being created. ||
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

## AdvancedRateLimiterProfile {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterProfile}

A AdvancedRateLimiterProfile (ARL) resource.

#|
||Field | Description ||
|| id | **string**

ID of the ARL profile. ||
|| folderId | **string**

ID of the folder that the ARL profile belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| name | **string**

Required field. Name of the ARL profile. The name is unique within the folder. 1-50 characters long. ||
|| description | **string**

Optional description of the ARL profile. ||
|| advancedRateLimiterRules[] | **[AdvancedRateLimiterRule](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule2)**

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

## AdvancedRateLimiterRule {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule2}

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
|| staticQuota | **[StaticQuota](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.StaticQuota2)**

Static quota. Counting each request individually.

Includes only one of the fields `staticQuota`, `dynamicQuota`. ||
|| dynamicQuota | **[DynamicQuota](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota2)**

Dynamic quota. Grouping requests by a certain attribute and limiting the number of groups.

Includes only one of the fields `staticQuota`, `dynamicQuota`. ||
|#

## StaticQuota {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.StaticQuota2}

StaticQuota object.

#|
||Field | Description ||
|| action | **enum** (Action)

Action in case of exceeding this quota.

- `ACTION_UNSPECIFIED`
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition2)**

The condition for matching the quota. ||
|| limit | **string** (int64)

Desired maximum number of requests per period.
Enter an integer within the range of 1 and 9999999999999. ||
|| period | **string** (int64)

Period of time in seconds. ||
|#

## Condition {#yandex.cloud.smartwebsecurity.v1.Condition2}

Condition object. AND semantics implied.
See [documentation](/docs/smartwebsecurity/concepts/conditions) for matchers description.

#|
||Field | Description ||
|| authority | **[AuthorityMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.AuthorityMatcher2)**

Match authority (Host header). ||
|| httpMethod | **[HttpMethodMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher2)**

Match HTTP method. ||
|| requestUri | **[RequestUriMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.RequestUriMatcher2)**

Match Request URI. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.HeaderMatcher2)**

Match HTTP headers. ||
|| sourceIp | **[IpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpMatcher2)**

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

## HttpMethodMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.HttpMethodMatcher2}

HttpMethodMatcher object.

#|
||Field | Description ||
|| httpMethods[] | **[StringMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.StringMatcher2)**

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
|| ipRangesMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher2)** ||
|| ipRangesNotMatch | **[IpRangesMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher2)** ||
|| geoIpMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher2)** ||
|| geoIpNotMatch | **[GeoIpMatcher](#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher2)** ||
|#

## IpRangesMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.IpRangesMatcher2}

IpRangesMatcher object.

#|
||Field | Description ||
|| ipRanges[] | **string**

List of IP ranges. OR semantics implied. ||
|#

## GeoIpMatcher {#yandex.cloud.smartwebsecurity.v1.Condition.GeoIpMatcher2}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied. ||
|#

## DynamicQuota {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota2}

DynamicQuota object.

#|
||Field | Description ||
|| action | **enum** (Action)

Action in case of exceeding this quota.

- `ACTION_UNSPECIFIED`
- `DENY`: Deny request. ||
|| condition | **[Condition](#yandex.cloud.smartwebsecurity.v1.Condition2)**

The condition for matching the quota. ||
|| limit | **string** (int64)

Desired maximum number of requests per period.
Enter an integer within the range of 1 and 9999999999999. ||
|| period | **string** (int64)

Period of time in seconds. ||
|| characteristics[] | **[Characteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic2)**

List of characteristics. ||
|#

## Characteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic2}

#|
||Field | Description ||
|| simpleCharacteristic | **[SimpleCharacteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.SimpleCharacteristic2)**

Characteristic automatically based on the Request path, HTTP method, IP address, Region, and Host attributes.
See [Rules](/docs/smartwebsecurity/concepts/arl#requests-counting) for more details.

Includes only one of the fields `simpleCharacteristic`, `keyCharacteristic`. ||
|| keyCharacteristic | **[KeyCharacteristic](#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.KeyCharacteristic2)**

Characteristic based on key match in the Query params, HTTP header, and HTTP cookie attributes.
See [Rules](/docs/smartwebsecurity/concepts/arl#requests-counting) for more details.

Includes only one of the fields `simpleCharacteristic`, `keyCharacteristic`. ||
|| caseInsensitive | **boolean**

Determines case-sensitive or case-insensitive keys matching. ||
|#

## SimpleCharacteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.SimpleCharacteristic2}

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

## KeyCharacteristic {#yandex.cloud.smartwebsecurity.v1.advanced_rate_limiter.AdvancedRateLimiterRule.DynamicQuota.Characteristic.KeyCharacteristic2}

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