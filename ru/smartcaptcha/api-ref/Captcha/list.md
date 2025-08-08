---
editable: false
apiPlayground:
  - url: https://smartcaptcha.{{ api-host }}/smartcaptcha/v1/captchas
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder that the captcha belongs to.
            Currently page_size, page_token, filter and order_by are not supported and List method will return all captchas in the folder.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/smartcaptcha/v1/api-ref/Captcha/list.md
---

# SmartCaptcha API, REST: Captcha.List

Retrieves the list of Captcha resources in the specified folder.

## HTTP request

```
GET https://smartcaptcha.{{ api-host }}/smartcaptcha/v1/captchas
```

## Query parameters {#yandex.cloud.smartcaptcha.v1.ListCaptchasRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder that the captcha belongs to.
Currently page_size, page_token, filter and order_by are not supported and List method will return all captchas in the folder. ||
|#

## Response {#yandex.cloud.smartcaptcha.v1.ListCaptchasResponse}

**HTTP Code: 200 - OK**

```json
{
  "resources": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "clientKey": "string",
      "createdAt": "string",
      "name": "string",
      "allowedSites": [
        "string"
      ],
      "complexity": "string",
      "styleJson": "string",
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
              ]
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
      "deletionProtection": "boolean",
      "overrideVariants": [
        {
          "uuid": "string",
          "description": "string",
          "complexity": "string",
          "preCheckType": "string",
          "challengeType": "string"
        }
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| resources[] | **[Captcha](#yandex.cloud.smartcaptcha.v1.Captcha)**

List of Captcha resources.
Currently next_page_token is not supported and List method will return all captchas in the folder. ||
|#

## Captcha {#yandex.cloud.smartcaptcha.v1.Captcha}

A Captcha resource.

#|
||Field | Description ||
|| id | **string**

ID of the captcha. ||
|| folderId | **string**

ID of the folder that the captcha belongs to. ||
|| cloudId | **string**

ID of the cloud that the captcha belongs to. ||
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

- `CAPTCHA_COMPLEXITY_UNSPECIFIED`
- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| styleJson | **string**

JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console. ||
|| suspend | **boolean**

Determines that the captcha is currently in restricted mode, see [SmartCaptcha restricted mode](/docs/smartcaptcha/concepts/restricted-mode). ||
|| turnOffHostnameCheck | **boolean**

Turn off host name check, see [Domain validation](/docs/smartcaptcha/concepts/domain-validation). ||
|| preCheckType | **enum** (CaptchaPreCheckType)

Basic check type of the captcha.

- `CAPTCHA_PRE_CHECK_TYPE_UNSPECIFIED`
- `CHECKBOX`: User must click the "I am not a robot" button.
- `SLIDER`: User must move the slider from left to right. ||
|| challengeType | **enum** (CaptchaChallengeType)

Additional task type of the captcha.

- `CAPTCHA_CHALLENGE_TYPE_UNSPECIFIED`
- `IMAGE_TEXT`: Text recognition: The user has to type a distorted text from the picture into a special field.
- `SILHOUETTES`: Silhouettes: The user has to mark several icons from the picture in a particular order.
- `KALEIDOSCOPE`: Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
|| securityRules[] | **[SecurityRule](#yandex.cloud.smartcaptcha.v1.SecurityRule)**

List of security rules. ||
|| deletionProtection | **boolean**

Determines whether captcha is protected from being deleted. ||
|| overrideVariants[] | **[OverrideVariant](#yandex.cloud.smartcaptcha.v1.OverrideVariant)**

List of variants to use in security_rules ||
|#

## SecurityRule {#yandex.cloud.smartcaptcha.v1.SecurityRule}

SecurityRule object. Defines the condition and action: when and which variant to show.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule. The name is unique within the captcha. 1-50 characters long. ||
|| priority | **string** (int64)

Priority of the rule. Lower value means higher priority. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
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

Host where captcha placed. ||
|| uri | **[UriMatcher](#yandex.cloud.smartcaptcha.v1.Condition.UriMatcher)**

URI where captcha placed. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartcaptcha.v1.Condition.HeaderMatcher)**

Captcha request headers. ||
|| sourceIp | **[IpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpMatcher)**

The IP address of the requester. ||
|#

## HostMatcher {#yandex.cloud.smartcaptcha.v1.Condition.HostMatcher}

HostMatcher object.

#|
||Field | Description ||
|| hosts[] | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

List of hosts. OR semantics implied. ||
|#

## StringMatcher {#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher}

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

## UriMatcher {#yandex.cloud.smartcaptcha.v1.Condition.UriMatcher}

UriMatcher object. AND semantics implied.

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). ||
|| queries[] | **[QueryMatcher](#yandex.cloud.smartcaptcha.v1.Condition.QueryMatcher)**

List of query matchers. AND semantics implied. ||
|#

## QueryMatcher {#yandex.cloud.smartcaptcha.v1.Condition.QueryMatcher}

QueryMatcher object.

#|
||Field | Description ||
|| key | **string**

Required field. Key of the query parameter. ||
|| value | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

Required field. Value of the query parameter. ||
|#

## HeaderMatcher {#yandex.cloud.smartcaptcha.v1.Condition.HeaderMatcher}

HeaderMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of header (case insensitive). ||
|| value | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

Required field. Value of the header. ||
|#

## IpMatcher {#yandex.cloud.smartcaptcha.v1.Condition.IpMatcher}

IpMatcher object. AND semantics implied.

#|
||Field | Description ||
|| ipRangesMatch | **[IpRangesMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher)** ||
|| ipRangesNotMatch | **[IpRangesMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher)** ||
|| geoIpMatch | **[GeoIpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher)** ||
|| geoIpNotMatch | **[GeoIpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher)** ||
|#

## IpRangesMatcher {#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher}

IpRangesMatcher object.

#|
||Field | Description ||
|| ipRanges[] | **string**

List of IP ranges. OR semantics implied. ||
|#

## GeoIpMatcher {#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied. ||
|#

## OverrideVariant {#yandex.cloud.smartcaptcha.v1.OverrideVariant}

OverrideVariant object. Contains the settings to override.

#|
||Field | Description ||
|| uuid | **string**

Unique identifier of the variant. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|| complexity | **enum** (CaptchaComplexity)

Complexity of the captcha.

- `CAPTCHA_COMPLEXITY_UNSPECIFIED`
- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| preCheckType | **enum** (CaptchaPreCheckType)

Basic check type of the captcha.

- `CAPTCHA_PRE_CHECK_TYPE_UNSPECIFIED`
- `CHECKBOX`: User must click the "I am not a robot" button.
- `SLIDER`: User must move the slider from left to right. ||
|| challengeType | **enum** (CaptchaChallengeType)

Additional task type of the captcha.

- `CAPTCHA_CHALLENGE_TYPE_UNSPECIFIED`
- `IMAGE_TEXT`: Text recognition: The user has to type a distorted text from the picture into a special field.
- `SILHOUETTES`: Silhouettes: The user has to mark several icons from the picture in a particular order.
- `KALEIDOSCOPE`: Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
|#