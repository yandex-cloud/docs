[Документация Yandex Cloud](../../../../../index.md) > [Yandex Certificate Manager](../../../../index.md) > Справочник API > gRPC (англ.) > [Certificate Manager Private CA API](../index.md) > [PrivateCa](index.md) > ImportCertificateAuthority

# Certificate Manager Private CA API, gRPC: PrivateCaService.ImportCertificateAuthority

Imports an externally generated Certificate Authority (CA).
You can import an existing CA from external PKI systems.

## gRPC request

**rpc ImportCertificateAuthority ([ImportCertificateAuthorityRequest](#yandex.cloud.certificatemanager.v1.privateca.ImportCertificateAuthorityRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ImportCertificateAuthorityRequest {#yandex.cloud.certificatemanager.v1.privateca.ImportCertificateAuthorityRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "certificate_content": "string",
  "key_pair": "string",
  "passphrase": "string",
  "end_entities_ttl_limit_days": "int64",
  "deletion_protection": "bool"
}
```

Request to import an externally generated Certificate Authority (CA).

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID where the CA is being created.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. The name of the imported Certificate Authority.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

A brief description of the imported Certificate Authority.

The maximum string length in characters is 1024. ||
|| certificate_content | **string**

Required field. PEM-encoded certificate content for the Certificate Authority. ||
|| key_pair | **string**

Required field. PEM-encoded key pair content for the CA (private key). ||
|| passphrase | **string**

PEM-encoded passphrase to decrypt the private key (if applicable). ||
|| end_entities_ttl_limit_days | **int64**

TTL limit in days for end-entities signed by the CA.

The maximum value is 20000. ||
|| deletion_protection | **bool**

Protect the CA from accidental deletion. ||
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