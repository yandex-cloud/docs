---
editable: false
---

# Certificate Manager API, gRPC: CertificateService.RequestNew

Request a certificate in the specified folder.

## gRPC request

**rpc RequestNew ([RequestNewCertificateRequest](#yandex.cloud.certificatemanager.v1.RequestNewCertificateRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RequestNewCertificateRequest {#yandex.cloud.certificatemanager.v1.RequestNewCertificateRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "labels": "map<string, string>",
  "domains": [
    "string"
  ],
  "challenge_type": "ChallengeType",
  "description": "string",
  "deletion_protection": "bool"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a certificate in.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the certificate.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| labels | **object** (map<**string**, **string**>)

Labels for the certificate as `key:value` pairs.

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| domains[] | **string**

Fully qualified domain names of the certificate. ||
|| challenge_type | enum **ChallengeType**

Type of the domain validation challenge.

- `DNS`: Domain validation type that using DNS-records.
- `HTTP`: Domain validation type that using HTTP-files. ||
|| description | **string**

Description of the certificate.

The maximum string length in characters is 1024. ||
|| deletion_protection | **bool**

Flag that protects deletion of the certificate ||
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