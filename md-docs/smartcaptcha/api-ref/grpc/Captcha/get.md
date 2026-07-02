[Документация Yandex Cloud](../../../../index.md) > [Yandex SmartCaptcha](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Captcha](index.md) > Get

# SmartCaptcha API, gRPC: CaptchaService.Get

Returns the specified Captcha resource.

## gRPC request

**rpc Get ([GetCaptchaRequest](#yandex.cloud.smartcaptcha.v1.GetCaptchaRequest)) returns ([Captcha](#yandex.cloud.smartcaptcha.v1.Captcha))**

## GetCaptchaRequest {#yandex.cloud.smartcaptcha.v1.GetCaptchaRequest}

```json
{
  "captcha_id": "string"
}
```

#|
||Field | Description ||
|| captcha_id | **string**

Required field. ID of the Captcha resource to return.

The maximum string length in characters is 50. ||
|#

## Captcha {#yandex.cloud.smartcaptcha.v1.Captcha}

```json
{
  "folder_id": "string",
  "client_key": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "allowed_sites": [
    "string"
  ],
  "complexity": "CaptchaComplexity",
  "style_json": "string",
  "cloud_id": "string",
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
          ],
          "host_matcher": {
            // Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`
            "exact_match": "string",
            "exact_not_match": "string",
            "prefix_match": "string",
            "prefix_not_match": "string",
            "pire_regex_match": "string",
            "pire_regex_not_match": "string"
            // end of the list of possible fields
          }
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
  "id": "string",
  "deletion_protection": "bool",
  "override_variants": [
    {
      "uuid": "string",
      "description": "string",
      "complexity": "CaptchaComplexity",
      "pre_check_type": "CaptchaPreCheckType",
      "challenge_type": "CaptchaChallengeType"
    }
  ],
  "disallow_data_processing": "bool",
  "description": "string",
  "labels": "map<string, string>"
}
```

A Captcha resource.

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder that the captcha belongs to. ||
|| client_key | **string**

Client key of the captcha, see [CAPTCHA keys](../../../concepts/keys.md). ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the captcha. The name is unique within the folder. 3-63 characters long. ||
|| allowed_sites[] | **string**

List of allowed host names, see [Domain validation](../../../concepts/domain-validation.md). ||
|| complexity | enum **CaptchaComplexity**

Complexity of the captcha.

- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| style_json | **string**

JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console. ||
|| cloud_id | **string**

ID of the cloud that the captcha belongs to. ||
|| suspend | **bool**

Determines that the captcha is currently in restricted mode, see [SmartCaptcha restricted mode](../../../concepts/restricted-mode.md). ||
|| turn_off_hostname_check | **bool**

Turn off host name check, see [Domain validation](../../../concepts/domain-validation.md). ||
|| pre_check_type | enum **CaptchaPreCheckType**

Basic check type of the captcha.

- `CHECKBOX`: User must click the "I am not a robot" button.
- `SLIDER`: User must move the slider from left to right. ||
|| challenge_type | enum **CaptchaChallengeType**

Additional task type of the captcha.

- `IMAGE_TEXT`: Text recognition: The user has to type a distorted text from the picture into a special field.
- `SILHOUETTES`: Silhouettes: The user has to mark several icons from the picture in a particular order.
- `KALEIDOSCOPE`: Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
|| security_rules[] | **[SecurityRule](#yandex.cloud.smartcaptcha.v1.SecurityRule)**

List of security rules. ||
|| id | **string**

ID of the captcha. ||
|| deletion_protection | **bool**

Determines whether captcha is protected from being deleted. ||
|| override_variants[] | **[OverrideVariant](#yandex.cloud.smartcaptcha.v1.OverrideVariant)**

List of variants to use in security_rules

The maximum number of elements is 32. ||
|| disallow_data_processing | **bool**

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
|| priority | **int64**

Priority of the rule. Lower value means higher priority.

Acceptable values are 1 to 999999, inclusive. ||
|| description | **string**

Optional description of the rule. 0-512 characters long.

The maximum string length in characters is 512. ||
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

AND* semantics implied. ||
|| uri | **[UriMatcher](#yandex.cloud.smartcaptcha.v1.Condition.UriMatcher)**

URI where captcha placed. ||
|| headers[] | **[HeaderMatcher](#yandex.cloud.smartcaptcha.v1.Condition.HeaderMatcher)**

Captcha request headers.

The maximum number of elements is 20. ||
|| source_ip | **[IpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpMatcher)**

The IP address of the requester. ||
|#

## HostMatcher {#yandex.cloud.smartcaptcha.v1.Condition.HostMatcher}

HostMatcher object.

#|
||Field | Description ||
|| hosts[] | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

List of hosts. OR semantics implied.

The maximum number of elements is 20. ||
|| host_matcher | **[StringMatcher](#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher)**

Host matcher. ||
|#

## StringMatcher {#yandex.cloud.smartcaptcha.v1.Condition.StringMatcher}

StringMatcher object.

#|
||Field | Description ||
|| exact_match | **string**

Exact match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| exact_not_match | **string**

Exact not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| prefix_match | **string**

Prefix match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| prefix_not_match | **string**

Prefix not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| pire_regex_match | **string**

PIRE regex match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
|| pire_regex_not_match | **string**

PIRE regex not match condition.

The string length in characters must be 0-255.

Includes only one of the fields `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match`, `pire_regex_not_match`. ||
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
|| ip_ranges_match | **[IpRangesMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher)**

IP ranges to match with. ||
|| ip_ranges_not_match | **[IpRangesMatcher](#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher)**

IP ranges to not match with. ||
|| geo_ip_match | **[GeoIpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher)**

Geo locations to match with. ||
|| geo_ip_not_match | **[GeoIpMatcher](#yandex.cloud.smartcaptcha.v1.Condition.GeoIpMatcher)**

Geo locations to not match with. ||
|#

## IpRangesMatcher {#yandex.cloud.smartcaptcha.v1.Condition.IpRangesMatcher}

IpRangesMatcher object.

#|
||Field | Description ||
|| ip_ranges[] | **string**

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
|| complexity | enum **CaptchaComplexity**

Complexity of the captcha.

- `EASY`: High chance to pass pre-check and easy advanced challenge.
- `MEDIUM`: Medium chance to pass pre-check and normal advanced challenge.
- `HARD`: Little chance to pass pre-check and hard advanced challenge.
- `FORCE_HARD`: Impossible to pass pre-check and hard advanced challenge. ||
|| pre_check_type | enum **CaptchaPreCheckType**

Basic check type of the captcha.

- `CHECKBOX`: User must click the "I am not a robot" button.
- `SLIDER`: User must move the slider from left to right. ||
|| challenge_type | enum **CaptchaChallengeType**

Additional task type of the captcha.

- `IMAGE_TEXT`: Text recognition: The user has to type a distorted text from the picture into a special field.
- `SILHOUETTES`: Silhouettes: The user has to mark several icons from the picture in a particular order.
- `KALEIDOSCOPE`: Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
|#