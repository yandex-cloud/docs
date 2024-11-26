---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Secret/scheduleVersionDestruction.md
---

# Lockbox API, gRPC: SecretService.ScheduleVersionDestruction

Schedules the specified version for destruction.

Scheduled destruction can be cancelled with the [SecretService.CancelVersionDestruction](/docs/lockbox/api-ref/grpc/Secret/cancelVersionDestruction#CancelVersionDestruction) method.

## gRPC request

**rpc ScheduleVersionDestruction ([ScheduleVersionDestructionRequest](#yandex.cloud.lockbox.v1.ScheduleVersionDestructionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ScheduleVersionDestructionRequest {#yandex.cloud.lockbox.v1.ScheduleVersionDestructionRequest}

```json
{
  "secret_id": "string",
  "version_id": "string",
  "pending_period": "google.protobuf.Duration"
}
```

#|
||Field | Description ||
|| secret_id | **string**

Required field. ID of the secret whose version should be scheduled for destruction. ||
|| version_id | **string**

Required field. ID of the version to be destroyed. ||
|| pending_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time interval between the version destruction request and actual destruction.
Default value: 7 days. ||
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
    "secret_id": "string",
    "version_id": "string",
    "destroy_at": "google.protobuf.Timestamp"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "secret_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "destroy_at": "google.protobuf.Timestamp",
    "description": "string",
    "status": "Status",
    "payload_entry_keys": [
      "string"
    ],
    // Includes only one of the fields `password_payload_specification`
    "password_payload_specification": {
      "password_key": "string",
      "length": "int64",
      "include_uppercase": "google.protobuf.BoolValue",
      "include_lowercase": "google.protobuf.BoolValue",
      "include_digits": "google.protobuf.BoolValue",
      "include_punctuation": "google.protobuf.BoolValue",
      "included_punctuation": "string",
      "excluded_punctuation": "string"
    }
    // end of the list of possible fields
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
|| metadata | **[ScheduleVersionDestructionMetadata](#yandex.cloud.lockbox.v1.ScheduleVersionDestructionMetadata)**

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
|| response | **[Version](#yandex.cloud.lockbox.v1.Version)**

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

## ScheduleVersionDestructionMetadata {#yandex.cloud.lockbox.v1.ScheduleVersionDestructionMetadata}

#|
||Field | Description ||
|| secret_id | **string**

ID of the secret whose version is being scheduled for destruction. ||
|| version_id | **string**

ID of the version that is being scheduled for destruction. ||
|| destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Destruction timestamp. ||
|#

## Version {#yandex.cloud.lockbox.v1.Version}

#|
||Field | Description ||
|| id | **string**

ID of the version. ||
|| secret_id | **string**

ID of the secret that the version belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version was created. ||
|| destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version is going to be destroyed. Empty unless the status
is `SCHEDULED_FOR_DESTRUCTION`. ||
|| description | **string**

Description of the version. ||
|| status | enum **Status**

Status of the secret.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The version is active and the secret payload can be accessed.
- `SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed
is specified in the `Version.destroy_at` field.
- `DESTROYED`: The version is destroyed and cannot be recovered. ||
|| payload_entry_keys[] | **string**

Keys of the entries contained in the version payload. ||
|| password_payload_specification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

Includes only one of the fields `password_payload_specification`. ||
|#

## PasswordPayloadSpecification {#yandex.cloud.lockbox.v1.PasswordPayloadSpecification}

#|
||Field | Description ||
|| password_key | **string**

Required field. key of the entry to store generated password value ||
|| length | **int64**

password length; by default, a reasonable length will be decided ||
|| include_uppercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one A..Z character is included in the password, true by default ||
|| include_lowercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one a..z character is included in the password, true by default ||
|| include_digits | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one 0..9 character is included in the password, true by default ||
|| include_punctuation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default (there are 32): !"#$%&'()*+,-./:;<=>?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| included_punctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use (at most, all the 32) ||
|| excluded_punctuation | **string**

a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32) ||
|#