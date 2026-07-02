[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [ScanPolicy](index.md) > Get

# Yandex Cloud Registry API, REST: ScanPolicy.Get

Returns the specified scan policy.

## HTTP request

```
GET https://registry.api.cloud.yandex.net/cloud-registry/v1/scanPolicies/{scanPolicyId}
```

## Path parameters

#|
||Field | Description ||
|| scanPolicyId | **string**

Required field. ID of the scan policy.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.cloudregistry.v1.ScanPolicy}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "registryId": "string",
  "name": "string",
  "description": "string",
  "scanPolicyOptions": {
    "scanLangPackages": "boolean"
  },
  "rules": {
    "pushRule": {
      "paths": [
        "string"
      ],
      "disabled": "boolean"
    },
    "scheduleRules": [
      {
        "amount": "string",
        "intervalUnit": "string",
        "paths": [
          "string"
        ],
        "disabled": "boolean"
      }
    ]
  },
  "createdAt": "string",
  "disabled": "boolean"
}
```

#|
||Field | Description ||
|| id | **string**

Output only. ID of the scan policy. ||
|| registryId | **string**

ID of the registry that the scan policy belongs to.
Required. The maximum string length in characters is 50. ||
|| name | **string**

Name of the scan policy. ||
|| description | **string**

Description of the scan policy.
The maximum string length in characters is 256. ||
|| scanPolicyOptions | **[ScanPolicyOptions](#yandex.cloud.cloudregistry.v1.ScanPolicyOptions)**

Scan policy options. ||
|| rules | **[ScanRules](#yandex.cloud.cloudregistry.v1.ScanRules)**

The rules of scan policy. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| disabled | **boolean**

Turns off scan policy. ||
|#

## ScanPolicyOptions {#yandex.cloud.cloudregistry.v1.ScanPolicyOptions}

#|
||Field | Description ||
|| scanLangPackages | **boolean**

Flag indicating whether language packages should be scanned. ||
|#

## ScanRules {#yandex.cloud.cloudregistry.v1.ScanRules}

#|
||Field | Description ||
|| pushRule | **[PushRule](#yandex.cloud.cloudregistry.v1.PushRule)**

Description of on-push scan rule. ||
|| scheduleRules[] | **[ScheduledRule](#yandex.cloud.cloudregistry.v1.ScheduledRule)**

Description of time based rescan rule. ||
|#

## PushRule {#yandex.cloud.cloudregistry.v1.PushRule}

#|
||Field | Description ||
|| paths[] | **string**

List of paths that are scanned with rule. Child paths are included into parent node. "*" - means all artifacts in registry

Each value must match the regular expression ``` \*|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* ```. The number of elements must be greater than 0. ||
|| disabled | **boolean**

Turns off scan rule. ||
|#

## ScheduledRule {#yandex.cloud.cloudregistry.v1.ScheduledRule}

#|
||Field | Description ||
|| amount | **string** (int64)

Amount of time units for the scan interval.

Value must be greater than 0. ||
|| intervalUnit | **enum** (IntervalUnit)

Unit for the scan interval.

- `DAYS`: Time unit is days. ||
|| paths[] | **string**

List of paths that are scanned with rule. Child paths are included into parent node. "*" - means all artifacts in registry

Each value must match the regular expression ``` \*|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* ```. The number of elements must be in the range 1-1000. ||
|| disabled | **boolean**

Turns off scan rule. ||
|#