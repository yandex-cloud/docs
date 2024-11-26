---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/ScanPolicy/update.md
---

# Container Registry API, gRPC: ScanPolicyService.Update

Updates the specified scan policy.

## gRPC request

**rpc Update ([UpdateScanPolicyRequest](#yandex.cloud.containerregistry.v1.UpdateScanPolicyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateScanPolicyRequest {#yandex.cloud.containerregistry.v1.UpdateScanPolicyRequest}

```json
{
  "scan_policy_id": "string",
  "update_mask": "google.protobuf.FieldMask",
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
  }
}
```

#|
||Field | Description ||
|| scan_policy_id | **string**

Required field. ID of the scan policy. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the scan policy resource are going to be updated. ||
|| name | **string**

Name of the scan policy. ||
|| description | **string**

Description of the scan policy. ||
|| rules | **[ScanRules](#yandex.cloud.containerregistry.v1.ScanRules)**

Rules of the scan policy. ||
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
    "scan_policy_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
|| metadata | **[UpdateScanPolicyMetadata](#yandex.cloud.containerregistry.v1.UpdateScanPolicyMetadata)**

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
|| response | **[ScanPolicy](#yandex.cloud.containerregistry.v1.ScanPolicy)**

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

## UpdateScanPolicyMetadata {#yandex.cloud.containerregistry.v1.UpdateScanPolicyMetadata}

#|
||Field | Description ||
|| scan_policy_id | **string**

ID of the scan policy resource that is updated. ||
|#

## ScanPolicy {#yandex.cloud.containerregistry.v1.ScanPolicy}

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
|| rules | **[ScanRules](#yandex.cloud.containerregistry.v1.ScanRules2)**

The rules of scan policy. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp. ||
|| disabled | **bool**

Turns off scan policy. ||
|#

## ScanRules {#yandex.cloud.containerregistry.v1.ScanRules2}

#|
||Field | Description ||
|| push_rule | **[PushRule](#yandex.cloud.containerregistry.v1.PushRule2)**

Description of on-push scan rule. ||
|| schedule_rules[] | **[ScheduledRule](#yandex.cloud.containerregistry.v1.ScheduledRule2)**

Description of time based rescan rule. ||
|#

## PushRule {#yandex.cloud.containerregistry.v1.PushRule2}

#|
||Field | Description ||
|| repository_prefixes[] | **string**

List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry ||
|| disabled | **bool**

Turns off scan rule. ||
|#

## ScheduledRule {#yandex.cloud.containerregistry.v1.ScheduledRule2}

#|
||Field | Description ||
|| repository_prefixes[] | **string**

List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry ||
|| rescan_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Period of time since last scan to trigger automatic rescan. ||
|| disabled | **bool**

Turns off scan rule. ||
|#