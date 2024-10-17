---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/ScanPolicy/get.md
---

# Container Registry API, gRPC: ScanPolicyService.Get {#Get}

Returns the specified scan policy.

## gRPC request

**rpc Get ([GetScanPolicyRequest](#yandex.cloud.containerregistry.v1.GetScanPolicyRequest)) returns ([ScanPolicy](#yandex.cloud.containerregistry.v1.ScanPolicy))**

## GetScanPolicyRequest {#yandex.cloud.containerregistry.v1.GetScanPolicyRequest}

```json
{
  "scanPolicyId": "string"
}
```

#|
||Field | Description ||
|| scanPolicyId | **string**

Required field. ID of the scan policy. ||
|#

## ScanPolicy {#yandex.cloud.containerregistry.v1.ScanPolicy}

```json
{
  "id": "string",
  "registryId": "string",
  "name": "string",
  "description": "string",
  "rules": {
    "pushRule": {
      "repositoryPrefixes": [
        "string"
      ],
      "disabled": "bool"
    },
    "scheduleRules": [
      {
        "repositoryPrefixes": [
          "string"
        ],
        "rescanPeriod": "google.protobuf.Duration",
        "disabled": "bool"
      }
    ]
  },
  "createdAt": "google.protobuf.Timestamp",
  "disabled": "bool"
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
|| rules | **[ScanRules](#yandex.cloud.containerregistry.v1.ScanRules)**

The rules of scan policy. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp. ||
|| disabled | **bool**

Turns off scan policy. ||
|#

## ScanRules {#yandex.cloud.containerregistry.v1.ScanRules}

#|
||Field | Description ||
|| pushRule | **[PushRule](#yandex.cloud.containerregistry.v1.PushRule)**

Description of on-push scan rule. ||
|| scheduleRules[] | **[ScheduledRule](#yandex.cloud.containerregistry.v1.ScheduledRule)**

Description of time based rescan rule. ||
|#

## PushRule {#yandex.cloud.containerregistry.v1.PushRule}

#|
||Field | Description ||
|| repositoryPrefixes[] | **string**

List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry ||
|| disabled | **bool**

Turns off scan rule. ||
|#

## ScheduledRule {#yandex.cloud.containerregistry.v1.ScheduledRule}

#|
||Field | Description ||
|| repositoryPrefixes[] | **string**

List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry ||
|| rescanPeriod | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Period of time since last scan to trigger automatic rescan. ||
|| disabled | **bool**

Turns off scan rule. ||
|#