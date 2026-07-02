[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Registry](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [ScanPolicy](index.md) > Create

# Yandex Cloud Registry API, gRPC: ScanPolicyService.Create

Creates a scan policy for the specified registry.

## gRPC request

**rpc Create ([CreateScanPolicyRequest](#yandex.cloud.cloudregistry.v1.CreateScanPolicyRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateScanPolicyRequest {#yandex.cloud.cloudregistry.v1.CreateScanPolicyRequest}

```json
{
  "registry_id": "string",
  "name": "string",
  "description": "string",
  "scan_lang_packages": "bool",
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
  "disabled": "bool"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the scan policy registry.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the scan policy.

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| description | **string**

Description of the scan policy.

The maximum string length in characters is 256. ||
|| scan_lang_packages | **bool**

Flag indicating whether language packages should be scanned. ||
|| rules | **[ScanRules](#yandex.cloud.cloudregistry.v1.ScanRules)**

Rules of the scan policy. ||
|| disabled | **bool**

Turns off scan policy. ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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