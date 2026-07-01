# Certificate Manager Private CA API, gRPC: PrivateCaService.Update

Updates the specified Certificate Authority (CA).
This allows updating attributes of an already existing CA, such as name, description, etc.

## gRPC request

**rpc Update ([UpdateCertificateAuthorityRequest](#yandex.cloud.certificatemanager.v1.privateca.UpdateCertificateAuthorityRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateCertificateAuthorityRequest {#yandex.cloud.certificatemanager.v1.privateca.UpdateCertificateAuthorityRequest}

```json
{
  "certificate_authority_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "deletion_protection": "bool",
  "end_entities_ttl_limit_days": "int64"
}
```

Request to update existing properties of a Certificate Authority.
Only fields specified in `update_mask` will be updated.

#|
||Field | Description ||
|| certificate_authority_id | **string**

Required field. The ID of the Certificate Authority to update.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that indicates which fields of the CA are being updated. ||
|| name | **string**

New name of the Certificate Authority (if applicable).
This field is optional and will only be applied if included in the update mask.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

New description of the Certificate Authority (if applicable).
Allows adding or updating the description to clarify the CA's purpose.

The maximum string length in characters is 1024. ||
|| deletion_protection | **bool**

Update the deletion protection flag.
Protects the Certificate Authority from accidental deletion. ||
|| end_entities_ttl_limit_days | **int64**

Update the end-entity TTL limit for certificates issued by this Certificate Authority.

The maximum value is 20000. ||
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

An Operation resource. For more information, see [Operation](../../../../../api-design-guide/concepts/operation.md).

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