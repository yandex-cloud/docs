---
editable: false
apiPlayground:
  - url: https://smartcaptcha.{{ api-host }}/smartcaptcha/v1/captchas/{captchaId}
    method: get
    path:
      type: object
      properties:
        captchaId:
          description: |-
            **string**
            Required field. ID of the Captcha resource to return.
            The maximum string length in characters is 50.
          type: string
      required:
        - captchaId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# SmartCaptcha API, REST: Captcha.Get

Returns the specified Captcha resource.

## HTTP request

```
GET https://smartcaptcha.{{ api-host }}/smartcaptcha/v1/captchas/{captchaId}
```

## Path parameters

#|
||Field | Description ||
|| captchaId | **string**

Required field. ID of the Captcha resource to return.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.smartcaptcha.v1.Captcha}

**HTTP Code: 200 - OK**

```json
{
  "folderId": "string",
  "clientKey": "string",
  "createdAt": "string",
  "name": "string",
  "allowedSites": [
    "string"
  ],
  "complexity": "string",
  "styleJson": "string",
  "cloudId": "string",
  "suspend": "boolean",
  "turnOffHostnameCheck": "boolean",
  "preCheckType": "string",
  "challengeType": "string",
  "securityRules": [
    {
      "name": "string",
      "priority": "string",
      "description": "string",
      "condition": {
        "host": {
          "hosts": [
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
          ],
          "hostMatcher": {
            // Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`
            "exactMatch": "string",
            "exactNotMatch": "string",
            "prefixMatch": "string",
            "prefixNotMatch": "string",
            "pireRegexMatch": "string",
            "pireRegexNotMatch": "string"
            // end of the list of possible fields
          }
        },
        "uri": {
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
      "overrideVariantUuid": "string"
    }
  ],
  "id": "string",
  "deletionProtection": "boolean",
  "overrideVariants": [
    {
      "uuid": "string",
      "description": "string",
      "complexity": "string",
      "preCheckType": "string",
      "challengeType": "string"
    }
  ],
  "disallowDataProcessing": "boolean",
  "description": "string",
  "labels": "object"
}
```

A Captcha resource.

#|
||Field | Description ||
|| folderId | **string**

ID of the folder that the captcha belongs to. ||
|| clientKey | **string**

Client key of the captcha, see [CAPTCHA keys](/docs/smartcaptcha/concepts/keys). ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the captcha. The name is unique within the folder. 3-63 characters long. ||
|| allowedSites[] | **string**

List of allowed host names, see [Domain validation](/docs/smartcaptcha/concepts/domain-validation). ||
|| complexity | **enum** (CaptchaComplexity)

Complexity of the captcha.

- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| styleJson | **string**

JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console. ||
|| cloudId | **string**

ID of the cloud that the captcha belongs to. ||
|| suspend | **boolean**

Determines that the captcha is currently in restricted mode, see [SmartCaptcha restricted mode](/docs/smartcaptcha/concepts/restricted-mode). ||
|| turnOffHostnameCheck | **boolean**

Turn off host name check, see [Domain validation](/docs/smartcaptcha/concepts/domain-validation). ||
|| preCheckType | **enum** (CaptchaPreCheckType)

Basic check type of the captcha.

- `CHECKBOX`: User must click the "I am not a robot" button.
- `SLIDER`: User must move the slider from left to right. ||
|| challengeType | **enum** (CaptchaChallengeType)

Additional task type of the captcha.

- `IMAGE_TEXT`: Text recognition: The user has to type a distorted text from the picture into a special field.
- `SILHOUETTES`: Silhouettes: The user has to mark several icons from the picture in a particular order.
- `KALEIDOSCOPE`: Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
|| securityRules[] | **[SecurityRule](#yandex.cloud.smartcaptcha.v1.SecurityRule)**

List of security rules. ||
|| id | **string**

ID of the captcha. ||
|| deletionProtection | **boolean**

Determines whether captcha is protected from being deleted. ||
|| overrideVariants[] | **[OverrideVariant](#yandex.cloud.smartcaptcha.v1.OverrideVariant)**

List of variants to use in security_rules

The maximum number of elements is 32. ||
|| disallowDataProcessing | **boolean**

Disables the use of HTTP request data for training and improving the service's ML models. ||
|| description | **string**

Optional description of the captcha.

The maximum string length in characters is 512. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## SecurityRule {#yandex.cloud.smartcaptcha.v1.SecurityRule}

SecurityRule object. Defines the condition and action: when and which variant to show.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule. The name is unique within the captcha. 1-50 characters long.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| priority | **string** (int64)

Priority of the rule. Lower value means higher priority.

Acceptable values are 1 to 999999, inclusive. ||
|| description | **string**

Optional description of the rule. 0-512 characters long.

The maximum string length in characters is 512. ||
|| condition | **[Condition](#yandex.cloud.smartcaptcha.v1.Condition)**

The condition for matching the rule. ||
|| overrideVariantUuid | **string**

Variant UUID to show in case of match the rule. Keep empty to use defaults. ||
|#

## Condition {#yandex.cloud.smartcaptcha.v1.Condition}

Condition object. AND semantics implied.

#|
||Field | Description ||
|| host | **[HostMatcher](#yandex.cloud.smartcaptcha.v1.Condition.HostMatcher)**

AND* semantics implied. ||
|| uri | **[UriMatcher](#yandex.cloud.smartcaptcha.v1.Condition.UriMatcher)**

URI where captcha placed. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartcaptcha.v1.Condition.HeaderMatcher)**

Captcha request headers.

The maximum number of elements is 20. ||
|| sourceIp | **[IpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpMatcher)**

The IP address of the requester. ||
|#

## HostMatcher {#yandex.cloud.smartcaptcha.v1.Condition.HostMatcher}

HostMatcher object.

#|
||Field | Description ||
|| hosts[] | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

List of hosts. OR semantics implied.

The maximum number of elements is 20. ||
|| hostMatcher | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

Host matcher. ||
|#

## StringMatcher {#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher}

StringMatcher object.

#|
||Field | Description ||
|| exactMatch | **string**

Exact match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| exactNotMatch | **string**

Exact not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixMatch | **string**

Prefix match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| prefixNotMatch | **string**

Prefix not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexMatch | **string**

PIRE regex match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|| pireRegexNotMatch | **string**

PIRE regex not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exactMatch`, `exactNotMatch`, `prefixMatch`, `prefixNotMatch`, `pireRegexMatch`, `pireRegexNotMatch`. ||
|#

## UriMatcher {#yandex.cloud.smartcaptcha.v1.Condition.UriMatcher}

UriMatcher object. AND semantics implied.

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). ||
|| queries[] | **[QueryMatcher](#yandex.cloud.smartcaptcha.v1.Condition.QueryMatcher)**

AND* semantics implied

The maximum number of elements is 20. ||
|#

## QueryMatcher {#yandex.cloud.smartcaptcha.v1.Condition.QueryMatcher}

QueryMatcher object.

#|
||Field | Description ||
|| key | **string**

Required field. Key of the query parameter.

The string length in characters must be 1-255. ||
|| value | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

Required field. Value of the query parameter. ||
|#

## HeaderMatcher {#yandex.cloud.smartcaptcha.v1.Condition.HeaderMatcher}

HeaderMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of header (case insensitive).

The string length in characters must be 1-255. ||
|| value | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

Required field. Value of the header. ||
|#

## IpMatcher {#yandex.cloud.smartcaptcha.v1.Condition.IpMatcher}

IpMatcher object. AND semantics implied.

#|
||Field | Description ||
|| ipRangesMatch | **[IpRangesMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher)**

IP ranges to match with. ||
|| ipRangesNotMatch | **[IpRangesMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher)**

IP ranges to not match with. ||
|| geoIpMatch | **[GeoIpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher)**

Geo locations to match with. ||
|| geoIpNotMatch | **[GeoIpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher)**

Geo locations to not match with. ||
|#

## IpRangesMatcher {#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher}

IpRangesMatcher object.

#|
||Field | Description ||
|| ipRanges[] | **string**

OR* semantics implied.

The string length in characters for each value must be greater than 0. The maximum number of elements is 10000. ||
|#

## GeoIpMatcher {#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

OR semantics implied. ISO 3166-1 alpha 2

The minimum number of elements is 1. ||
|#

## OverrideVariant {#yandex.cloud.smartcaptcha.v1.OverrideVariant}

OverrideVariant object. Contains the settings to override.

#|
||Field | Description ||
|| uuid | **string**

Unique identifier of the variant.

The maximum string length in characters is 64. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Optional description of the rule. 0-512 characters long.

The maximum string length in characters is 512. ||
|| complexity | **enum** (CaptchaComplexity)

Complexity of the captcha.

- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| preCheckType | **enum** (CaptchaPreCheckType)

Basic check type of the captcha.

- `CHECKBOX`: User must click the "I am not a robot" button.
- `SLIDER`: User must move the slider from left to right. ||
|| challengeType | **enum** (CaptchaChallengeType)

Additional task type of the captcha.

- `IMAGE_TEXT`: Text recognition: The user has to type a distorted text from the picture into a special field.
- `SILHOUETTES`: Silhouettes: The user has to mark several icons from the picture in a particular order.
- `KALEIDOSCOPE`: Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
|#