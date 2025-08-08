---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/Userpool/addDomain.md
---

# Identity Provider API, gRPC: UserpoolService.AddDomain

Adds a domain to the specified userpool.

## gRPC request

**rpc AddDomain ([AddUserpoolDomainRequest](#yandex.cloud.organizationmanager.v1.idp.AddUserpoolDomainRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddUserpoolDomainRequest {#yandex.cloud.organizationmanager.v1.idp.AddUserpoolDomainRequest}

```json
{
  "userpool_id": "string",
  "domain": "string"
}
```

Request to add a domain to a userpool.

#|
||Field | Description ||
|| userpool_id | **string**

ID of the userpool to add a domain to. ||
|| domain | **string**

Domain name to add. ||
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
    "userpool_id": "string",
    "domain": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "domain": "string",
    "status": "Status",
    "status_code": "string",
    "created_at": "google.protobuf.Timestamp",
    "validated_at": "google.protobuf.Timestamp",
    "challenges": [
      {
        "created_at": "google.protobuf.Timestamp",
        "updated_at": "google.protobuf.Timestamp",
        "type": "Type",
        "status": "Status",
        // Includes only one of the fields `dns_challenge`
        "dns_challenge": {
          "name": "string",
          "type": "Type",
          "value": "string"
        }
        // end of the list of possible fields
      }
    ],
    "deletion_protection": "bool"
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
|| metadata | **[AddUserpoolDomainMetadata](#yandex.cloud.organizationmanager.v1.idp.AddUserpoolDomainMetadata)**

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
|| response | **[Domain](#yandex.cloud.organizationmanager.v1.idp.Domain)**

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

## AddUserpoolDomainMetadata {#yandex.cloud.organizationmanager.v1.idp.AddUserpoolDomainMetadata}

Metadata for the [UserpoolService.AddDomain](#AddDomain) operation.

#|
||Field | Description ||
|| userpool_id | **string**

ID of the userpool. ||
|| domain | **string**

Domain name being added. ||
|#

## Domain {#yandex.cloud.organizationmanager.v1.idp.Domain}

A domain associated with a userpool.

#|
||Field | Description ||
|| domain | **string**

Domain name. ||
|| status | enum **Status**

Current status of the domain.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `NEED_TO_VALIDATE`: The domain needs to be validated.
- `VALIDATING`: The domain is in the process of being validated.
- `VALID`: The domain has been successfully validated.
- `INVALID`: The domain validation has failed.
- `DELETING`: The domain is in the process of being deleted. ||
|| status_code | **string**

Optional code providing details about validation errors. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the domain was created. ||
|| validated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the domain was validated. ||
|| challenges[] | **[DomainChallenge](#yandex.cloud.organizationmanager.v1.idp.DomainChallenge)**

List of challenges associated with this domain. ||
|| deletion_protection | **bool**

Whether the domain is protected from deletion. ||
|#

## DomainChallenge {#yandex.cloud.organizationmanager.v1.idp.DomainChallenge}

A challenge used to validate domain ownership.

#|
||Field | Description ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the challenge was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the challenge was last updated. ||
|| type | enum **Type**

Type of the challenge.

- `TYPE_UNSPECIFIED`: The type is not specified.
- `DNS_TXT`: DNS TXT record challenge. ||
|| status | enum **Status**

Current status of the challenge.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `PENDING`: The challenge is pending verification.
- `PROCESSING`: The challenge verification is in progress.
- `VALID`: The challenge has been successfully verified.
- `INVALID`: The challenge verification has failed. ||
|| dns_challenge | **[DnsRecord](#yandex.cloud.organizationmanager.v1.idp.DomainChallenge.DnsRecord)**

DNS record challenge details.

Includes only one of the fields `dns_challenge`.

Challenge details. ||
|#

## DnsRecord {#yandex.cloud.organizationmanager.v1.idp.DomainChallenge.DnsRecord}

DNS record information for domain validation.

#|
||Field | Description ||
|| name | **string**

Name of the DNS record. ||
|| type | enum **Type**

Type of the DNS record.

- `TYPE_UNSPECIFIED`: The type is not specified.
- `TXT`: TXT record type. ||
|| value | **string**

Value of the DNS record. ||
|#