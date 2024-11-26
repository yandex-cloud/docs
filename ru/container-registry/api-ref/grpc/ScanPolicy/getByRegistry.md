---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/ScanPolicy/getByRegistry.md
---

# Container Registry API, gRPC: ScanPolicyService.GetByRegistry

Returns scan policy for the registry if any exists.

## gRPC request

**rpc GetByRegistry ([GetScanPolicyByRegistryRequest](#yandex.cloud.containerregistry.v1.GetScanPolicyByRegistryRequest)) returns ([ScanPolicy](#yandex.cloud.containerregistry.v1.ScanPolicy))**

## GetScanPolicyByRegistryRequest {#yandex.cloud.containerregistry.v1.GetScanPolicyByRegistryRequest}

```json
{
  "registry_id": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the registry with scan policy. ||
|#

## ScanPolicy {#yandex.cloud.containerregistry.v1.ScanPolicy}

```json
{
  "id": "string",
  "registry_id": "string",
  "name": "string",
  "description": "string",
  "rules": {
    "push_rule": {
      "repository_prefixes": [
        "string"
      ],
      "disabled": "bool"
    },
    "schedule_rules": [
      {
        "repository_prefixes": [
          "string"
        ],
        "rescan_period": "google.protobuf.Duration",
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
|| rules | **[ScanRules](#yandex.cloud.containerregistry.v1.ScanRules)**

The rules of scan policy. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp. ||
|| disabled | **bool**

Turns off scan policy. ||
|#

## ScanRules {#yandex.cloud.containerregistry.v1.ScanRules}

#|
||Field | Description ||
|| push_rule | **[PushRule](#yandex.cloud.containerregistry.v1.PushRule)**

Description of on-push scan rule. ||
|| schedule_rules[] | **[ScheduledRule](#yandex.cloud.containerregistry.v1.ScheduledRule)**

Description of time based rescan rule. ||
|#

## PushRule {#yandex.cloud.containerregistry.v1.PushRule}

#|
||Field | Description ||
|| repository_prefixes[] | **string**

List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry ||
|| disabled | **bool**

Turns off scan rule. ||
|#

## ScheduledRule {#yandex.cloud.containerregistry.v1.ScheduledRule}

#|
||Field | Description ||
|| repository_prefixes[] | **string**

List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry ||
|| rescan_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Period of time since last scan to trigger automatic rescan. ||
|| disabled | **bool**

Turns off scan rule. ||
|#