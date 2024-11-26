---
editable: false
sourcePath: en/_api-ref-grpc/smartcaptcha/v1/api-ref/grpc/Captcha/update.md
---

# SmartCaptcha API, gRPC: CaptchaService.Update

Updates the specified captcha.

## gRPC request

**rpc Update ([UpdateCaptchaRequest](#yandex.cloud.smartcaptcha.v1.UpdateCaptchaRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateCaptchaRequest {#yandex.cloud.smartcaptcha.v1.UpdateCaptchaRequest}

```json
{
  "captcha_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "allowed_sites": [
    "string"
  ],
  "complexity": "CaptchaComplexity",
  "style_json": "string",
  "turn_off_hostname_check": "bool",
  "pre_check_type": "CaptchaPreCheckType",
  "challenge_type": "CaptchaChallengeType",
  "security_rules": [
    {
      "name": "string",
      "priority": "int64",
      "description": "string",
      "condition": {
        "host": {
          "hosts": [
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
        "uri": {
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
      "override_variant_uuid": "string"
    }
  ],
  "deletion_protection": "bool",
  "override_variants": [
    {
      "uuid": "string",
      "description": "string",
      "complexity": "CaptchaComplexity",
      "pre_check_type": "CaptchaPreCheckType",
      "challenge_type": "CaptchaChallengeType"
    }
  ]
}
```

#|
||Field | Description ||
|| captcha_id | **string**

Required field. ID of the captcha to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Captcha resource are going to be updated. ||
|| name | **string**

Name of the captcha.
The name must be unique within the folder. ||
|| allowed_sites[] | **string**

List of allowed host names, see [Domain validation](/docs/smartcaptcha/concepts/domain-validation). ||
|| complexity | enum **CaptchaComplexity**

Complexity of the captcha.

- `CAPTCHA_COMPLEXITY_UNSPECIFIED`
- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| style_json | **string**

JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console. ||
|| turn_off_hostname_check | **bool**

Turn off host name check, see [Domain validation](/docs/smartcaptcha/concepts/domain-validation). ||
|| pre_check_type | enum **CaptchaPreCheckType**

Basic check type of the captcha.

- `CAPTCHA_PRE_CHECK_TYPE_UNSPECIFIED`
- `CHECKBOX`: User must click the "I am not a robot" button.
- `SLIDER`: User must move the slider from left to right. ||
|| challenge_type | enum **CaptchaChallengeType**

Additional task type of the captcha.

- `CAPTCHA_CHALLENGE_TYPE_UNSPECIFIED`
- `IMAGE_TEXT`: Text recognition: The user has to type a distorted text from the picture into a special field.
- `SILHOUETTES`: Silhouettes: The user has to mark several icons from the picture in a particular order.
- `KALEIDOSCOPE`: Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
|| security_rules[] | **[SecurityRule](#yandex.cloud.smartcaptcha.v1.SecurityRule)**

List of security rules. ||
|| deletion_protection | **bool**

Determines whether captcha is protected from being deleted. ||
|| override_variants[] | **[OverrideVariant](#yandex.cloud.smartcaptcha.v1.OverrideVariant)**

List of variants to use in security_rules ||
|#

## SecurityRule {#yandex.cloud.smartcaptcha.v1.SecurityRule}

SecurityRule object. Defines the condition and action: when and which variant to show.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule. The name is unique within the captcha. 1-50 characters long. ||
|| priority | **int64**

Priority of the rule. Lower value means higher priority. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|| condition | **[Condition](#yandex.cloud.smartcaptcha.v1.Condition)**

The condition for matching the rule. ||
|| override_variant_uuid | **string**

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
|| source_ip | **[IpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpMatcher)**

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
|| ip_ranges_match | **[IpRangesMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher)** ||
|| ip_ranges_not_match | **[IpRangesMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher)** ||
|| geo_ip_match | **[GeoIpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher)** ||
|| geo_ip_not_match | **[GeoIpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher)** ||
|#

## IpRangesMatcher {#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher}

IpRangesMatcher object.

#|
||Field | Description ||
|| ip_ranges[] | **string**

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
|| complexity | enum **CaptchaComplexity**

Complexity of the captcha.

- `CAPTCHA_COMPLEXITY_UNSPECIFIED`
- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| pre_check_type | enum **CaptchaPreCheckType**

Basic check type of the captcha.

- `CAPTCHA_PRE_CHECK_TYPE_UNSPECIFIED`
- `CHECKBOX`: User must click the "I am not a robot" button.
- `SLIDER`: User must move the slider from left to right. ||
|| challenge_type | enum **CaptchaChallengeType**

Additional task type of the captcha.

- `CAPTCHA_CHALLENGE_TYPE_UNSPECIFIED`
- `IMAGE_TEXT`: Text recognition: The user has to type a distorted text from the picture into a special field.
- `SILHOUETTES`: Silhouettes: The user has to mark several icons from the picture in a particular order.
- `KALEIDOSCOPE`: Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
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
    "captcha_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "cloud_id": "string",
    "client_key": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "allowed_sites": [
      "string"
    ],
    "complexity": "CaptchaComplexity",
    "style_json": "string",
    "suspend": "bool",
    "turn_off_hostname_check": "bool",
    "pre_check_type": "CaptchaPreCheckType",
    "challenge_type": "CaptchaChallengeType",
    "security_rules": [
      {
        "name": "string",
        "priority": "int64",
        "description": "string",
        "condition": {
          "host": {
            "hosts": [
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
          "uri": {
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
        "override_variant_uuid": "string"
      }
    ],
    "deletion_protection": "bool",
    "override_variants": [
      {
        "uuid": "string",
        "description": "string",
        "complexity": "CaptchaComplexity",
        "pre_check_type": "CaptchaPreCheckType",
        "challenge_type": "CaptchaChallengeType"
      }
    ]
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
|| metadata | **[UpdateCaptchaMetadata](#yandex.cloud.smartcaptcha.v1.UpdateCaptchaMetadata)**

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
|| response | **[Captcha](#yandex.cloud.smartcaptcha.v1.Captcha)**

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

## UpdateCaptchaMetadata {#yandex.cloud.smartcaptcha.v1.UpdateCaptchaMetadata}

#|
||Field | Description ||
|| captcha_id | **string**

ID of the Captcha resource that is being updated. ||
|#

## Captcha {#yandex.cloud.smartcaptcha.v1.Captcha}

A Captcha resource.

#|
||Field | Description ||
|| id | **string**

ID of the captcha. ||
|| folder_id | **string**

ID of the folder that the captcha belongs to. ||
|| cloud_id | **string**

ID of the cloud that the captcha belongs to. ||
|| client_key | **string**

Client key of the captcha, see [CAPTCHA keys](/docs/smartcaptcha/concepts/keys). ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the captcha. The name is unique within the folder. 3-63 characters long. ||
|| allowed_sites[] | **string**

List of allowed host names, see [Domain validation](/docs/smartcaptcha/concepts/domain-validation). ||
|| complexity | enum **CaptchaComplexity**

Complexity of the captcha.

- `CAPTCHA_COMPLEXITY_UNSPECIFIED`
- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| style_json | **string**

JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console. ||
|| suspend | **bool**

Determines that the captcha is currently in restricted mode, see [SmartCaptcha restricted mode](/docs/smartcaptcha/concepts/restricted-mode). ||
|| turn_off_hostname_check | **bool**

Turn off host name check, see [Domain validation](/docs/smartcaptcha/concepts/domain-validation). ||
|| pre_check_type | enum **CaptchaPreCheckType**

Basic check type of the captcha.

- `CAPTCHA_PRE_CHECK_TYPE_UNSPECIFIED`
- `CHECKBOX`: User must click the "I am not a robot" button.
- `SLIDER`: User must move the slider from left to right. ||
|| challenge_type | enum **CaptchaChallengeType**

Additional task type of the captcha.

- `CAPTCHA_CHALLENGE_TYPE_UNSPECIFIED`
- `IMAGE_TEXT`: Text recognition: The user has to type a distorted text from the picture into a special field.
- `SILHOUETTES`: Silhouettes: The user has to mark several icons from the picture in a particular order.
- `KALEIDOSCOPE`: Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
|| security_rules[] | **[SecurityRule](#yandex.cloud.smartcaptcha.v1.SecurityRule2)**

List of security rules. ||
|| deletion_protection | **bool**

Determines whether captcha is protected from being deleted. ||
|| override_variants[] | **[OverrideVariant](#yandex.cloud.smartcaptcha.v1.OverrideVariant2)**

List of variants to use in security_rules ||
|#

## SecurityRule {#yandex.cloud.smartcaptcha.v1.SecurityRule2}

SecurityRule object. Defines the condition and action: when and which variant to show.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule. The name is unique within the captcha. 1-50 characters long. ||
|| priority | **int64**

Priority of the rule. Lower value means higher priority. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|| condition | **[Condition](#yandex.cloud.smartcaptcha.v1.Condition2)**

The condition for matching the rule. ||
|| override_variant_uuid | **string**

Variant UUID to show in case of match the rule. Keep empty to use defaults. ||
|#

## Condition {#yandex.cloud.smartcaptcha.v1.Condition2}

Condition object. AND semantics implied.

#|
||Field | Description ||
|| host | **[HostMatcher](#yandex.cloud.smartcaptcha.v1.Condition.HostMatcher2)**

Host where captcha placed. ||
|| uri | **[UriMatcher](#yandex.cloud.smartcaptcha.v1.Condition.UriMatcher2)**

URI where captcha placed. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartcaptcha.v1.Condition.HeaderMatcher2)**

Captcha request headers. ||
|| source_ip | **[IpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpMatcher2)**

The IP address of the requester. ||
|#

## HostMatcher {#yandex.cloud.smartcaptcha.v1.Condition.HostMatcher2}

HostMatcher object.

#|
||Field | Description ||
|| hosts[] | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher2)**

List of hosts. OR semantics implied. ||
|#

## StringMatcher {#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher2}

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

## UriMatcher {#yandex.cloud.smartcaptcha.v1.Condition.UriMatcher2}

UriMatcher object. AND semantics implied.

#|
||Field | Description ||
|| path | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher2)**

Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). ||
|| queries[] | **[QueryMatcher](#yandex.cloud.smartcaptcha.v1.Condition.QueryMatcher2)**

List of query matchers. AND semantics implied. ||
|#

## QueryMatcher {#yandex.cloud.smartcaptcha.v1.Condition.QueryMatcher2}

QueryMatcher object.

#|
||Field | Description ||
|| key | **string**

Required field. Key of the query parameter. ||
|| value | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher2)**

Required field. Value of the query parameter. ||
|#

## HeaderMatcher {#yandex.cloud.smartcaptcha.v1.Condition.HeaderMatcher2}

HeaderMatcher object.

#|
||Field | Description ||
|| name | **string**

Required field. Name of header (case insensitive). ||
|| value | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher2)**

Required field. Value of the header. ||
|#

## IpMatcher {#yandex.cloud.smartcaptcha.v1.Condition.IpMatcher2}

IpMatcher object. AND semantics implied.

#|
||Field | Description ||
|| ip_ranges_match | **[IpRangesMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher2)** ||
|| ip_ranges_not_match | **[IpRangesMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher2)** ||
|| geo_ip_match | **[GeoIpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher2)** ||
|| geo_ip_not_match | **[GeoIpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher2)** ||
|#

## IpRangesMatcher {#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher2}

IpRangesMatcher object.

#|
||Field | Description ||
|| ip_ranges[] | **string**

List of IP ranges. OR semantics implied. ||
|#

## GeoIpMatcher {#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher2}

GeoIpMatcher object.

#|
||Field | Description ||
|| locations[] | **string**

ISO 3166-1 alpha 2. OR semantics implied. ||
|#

## OverrideVariant {#yandex.cloud.smartcaptcha.v1.OverrideVariant2}

OverrideVariant object. Contains the settings to override.

#|
||Field | Description ||
|| uuid | **string**

Unique identifier of the variant. ||
|| description | **string**

Optional description of the rule. 0-512 characters long. ||
|| complexity | enum **CaptchaComplexity**

Complexity of the captcha.

- `CAPTCHA_COMPLEXITY_UNSPECIFIED`
- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| pre_check_type | enum **CaptchaPreCheckType**

Basic check type of the captcha.

- `CAPTCHA_PRE_CHECK_TYPE_UNSPECIFIED`
- `CHECKBOX`: User must click the "I am not a robot" button.
- `SLIDER`: User must move the slider from left to right. ||
|| challenge_type | enum **CaptchaChallengeType**

Additional task type of the captcha.

- `CAPTCHA_CHALLENGE_TYPE_UNSPECIFIED`
- `IMAGE_TEXT`: Text recognition: The user has to type a distorted text from the picture into a special field.
- `SILHOUETTES`: Silhouettes: The user has to mark several icons from the picture in a particular order.
- `KALEIDOSCOPE`: Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
|#