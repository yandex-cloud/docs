# SmartCaptcha API, REST: Captcha.Create

Creates a captcha in the specified folder using the data specified in the request.

## HTTP request

```
POST https://smartcaptcha.api.cloud.yandex.net/smartcaptcha/v1/captchas
```

## Body parameters {#yandex.cloud.smartcaptcha.v1.CreateCaptchaRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "allowedSites": [
    "string"
  ],
  "complexity": "string",
  "styleJson": "string",
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

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a captcha in.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the captcha.
The name must be unique within the folder.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| allowedSites[] | **string**

List of allowed host names, see [Domain validation](../../concepts/domain-validation.md). ||
|| complexity | **enum** (CaptchaComplexity)

Complexity of the captcha.

- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| styleJson | **string**

JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console. ||
|| turnOffHostnameCheck | **boolean**

Turn off host name check, see [Domain validation](../../concepts/domain-validation.md). ||
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
|| deletionProtection | **boolean**

Determines whether captcha is protected from being deleted. ||
|| overrideVariants[] | **[OverrideVariant](#yandex.cloud.smartcaptcha.v1.OverrideVariant)**

List of variants to use in security_rules ||
|| disallowDataProcessing | **boolean**

If true, Yandex team won't be able to read internal data. ||
|| description | **string**

Optional description of the captcha.

The maximum string length in characters is 512. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

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
|| metadata | **object**

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
|| response | **object**

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