# Yandex Cloud Registry API, gRPC: ScanPolicyService.GetByRegistry

Returns scan policy for the registry if any exists.

## gRPC request

**rpc GetByRegistry ([GetScanPolicyByRegistryRequest](#yandex.cloud.cloudregistry.v1.GetScanPolicyByRegistryRequest)) returns ([ScanPolicy](#yandex.cloud.cloudregistry.v1.ScanPolicy))**

## GetScanPolicyByRegistryRequest {#yandex.cloud.cloudregistry.v1.GetScanPolicyByRegistryRequest}

```json
{
  "registry_id": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the registry with scan policy.

The maximum string length in characters is 50. ||
|#

## ScanPolicy {#yandex.cloud.cloudregistry.v1.ScanPolicy}

```json
{
  "id": "string",
  "registry_id": "string",
  "name": "string",
  "description": "string",
  "scan_policy_options": {
    "scan_lang_packages": "bool"
  },
  "rules": {
    "push_rule": {
      "paths": [
        "string"
      ],
      "disabled": "bool"
    },
    "schedule_rules": [
      {
        "amount": "int64",
        "interval_unit": "IntervalUnit",
        "paths": [
          "string"
        ],
        "disabled": "bool"
      }
    ]
  },
  "created_at": "google.protobuf.Timestamp",
  "disabled": "bool"
}
```

#|
||Field | Description ||
|| id | **string**

Output only. ID of the scan policy. ||
|| registry_id | **string**

ID of the registry that the scan policy belongs to.
Required. The maximum string length in characters is 50. ||
|| name | **string**

Name of the scan policy. ||
|| description | **string**

Description of the scan policy.
The maximum string length in characters is 256. ||
|| scan_policy_options | **[ScanPolicyOptions](#yandex.cloud.cloudregistry.v1.ScanPolicyOptions)**

Scan policy options. ||
|| rules | **[ScanRules](#yandex.cloud.cloudregistry.v1.ScanRules)**

The rules of scan policy. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp. ||
|| disabled | **bool**

Turns off scan policy. ||
|#

## ScanPolicyOptions {#yandex.cloud.cloudregistry.v1.ScanPolicyOptions}

#|
||Field | Description ||
|| scan_lang_packages | **bool**

Flag indicating whether language packages should be scanned. ||
|#

## ScanRules {#yandex.cloud.cloudregistry.v1.ScanRules}

#|
||Field | Description ||
|| push_rule | **[PushRule](#yandex.cloud.cloudregistry.v1.PushRule)**

Description of on-push scan rule. ||
|| schedule_rules[] | **[ScheduledRule](#yandex.cloud.cloudregistry.v1.ScheduledRule)**

Description of time based rescan rule. ||
|#

## PushRule {#yandex.cloud.cloudregistry.v1.PushRule}

#|
||Field | Description ||
|| paths[] | **string**

List of paths that are scanned with rule. Child paths are included into parent node. "*" - means all artifacts in registry

Each value must match the regular expression ``` \*|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* ```. The number of elements must be greater than 0. ||
|| disabled | **bool**

Turns off scan rule. ||
|#

## ScheduledRule {#yandex.cloud.cloudregistry.v1.ScheduledRule}

#|
||Field | Description ||
|| amount | **int64**

Amount of time units for the scan interval.

Value must be greater than 0. ||
|| interval_unit | enum **IntervalUnit**

Unit for the scan interval.

- `DAYS`: Time unit is days. ||
|| paths[] | **string**

List of paths that are scanned with rule. Child paths are included into parent node. "*" - means all artifacts in registry

Each value must match the regular expression ``` \*|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* ```. The number of elements must be in the range 1-1000. ||
|| disabled | **bool**

Turns off scan rule. ||
|#