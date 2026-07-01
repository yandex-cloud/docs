# Lockbox API, gRPC: SecretService.AddVersion

Adds new version based on a previous one.

## gRPC request

**rpc AddVersion ([AddVersionRequest](#yandex.cloud.lockbox.v1.AddVersionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddVersionRequest {#yandex.cloud.lockbox.v1.AddVersionRequest}

```json
{
  "secret_id": "string",
  "description": "string",
  "payload_entries": [
    {
      // Includes only one of the fields `text_value`, `binary_value`
      "text_value": "string",
      "binary_value": "bytes",
      // end of the list of possible fields
      "key": "string"
    }
  ],
  "base_version_id": "string"
}
```

#|
||Field | Description ||
|| secret_id | **string**

Required field. ID of the secret.

The maximum string length in characters is 50. ||
|| description | **string**

Description of the version.

The maximum string length in characters is 1024. ||
|| payload_entries[] | **[PayloadEntryChange](#yandex.cloud.lockbox.v1.PayloadEntryChange)**

Describe how payload entries of the base version change in the added version. ||
|| base_version_id | **string**

Optional base version id. Defaults to the current version if not specified

The maximum string length in characters is 50. ||
|#

## PayloadEntryChange {#yandex.cloud.lockbox.v1.PayloadEntryChange}

#|
||Field | Description ||
|| text_value | **string**

Use the field to set a text value.

The maximum string length in characters is 65536.

Includes only one of the fields `text_value`, `binary_value`.

Confidential value of the entry. ||
|| binary_value | **bytes**

Use the field to set a binary value.

The maximum string length in characters is 65536.

Includes only one of the fields `text_value`, `binary_value`.

Confidential value of the entry. ||
|| key | **string**

Required field. Non-confidential key of the entry.

The maximum string length in characters is 256. Value must match the regular expression ` [-_./\\@0-9a-zA-Z]+ `. ||
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