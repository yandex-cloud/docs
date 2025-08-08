---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/saml/api-ref/grpc/Federation/validateDomain.md
---

# SAML Federation API, gRPC: FederationService.ValidateDomain

Validates a domain in the specified federation.

## gRPC request

**rpc ValidateDomain ([ValidateFederationDomainRequest](#yandex.cloud.organizationmanager.v1.saml.ValidateFederationDomainRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ValidateFederationDomainRequest {#yandex.cloud.organizationmanager.v1.saml.ValidateFederationDomainRequest}

```json
{
  "federation_id": "string",
  "domain": "string"
}
```

#|
||Field | Description ||
|| federation_id | **string**

Required field. ID of the federation to validate a domain for.
To get the federation ID, make a [FederationService.List](/docs/organization/saml/api-ref/grpc/Federation/list#List) request. ||
|| domain | **string**

Required field. Domain name to validate for the federation.
Must be a valid domain name (1-253 characters). ||
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
    "federation_id": "string",
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
    ]
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
|| metadata | **[ValidateFederationDomainMetadata](#yandex.cloud.organizationmanager.v1.saml.ValidateFederationDomainMetadata)**

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
|| response | **[Domain](#yandex.cloud.organizationmanager.v1.saml.Domain)**

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

## ValidateFederationDomainMetadata {#yandex.cloud.organizationmanager.v1.saml.ValidateFederationDomainMetadata}

#|
||Field | Description ||
|| federation_id | **string**

ID of the federation that the domain validation is being performed for. ||
|| domain | **string**

Domain name that is being validated for the federation. ||
|#

## Domain {#yandex.cloud.organizationmanager.v1.saml.Domain}

A domain.

#|
||Field | Description ||
|| domain | **string**

Domain name ||
|| status | enum **Status**

Current status of the domain.

- `STATUS_UNSPECIFIED`
- `NEED_TO_VALIDATE`: Domain requires ownership validation.
- `VALIDATING`: Domain validation is in progress.
- `VALID`: Domain has been successfully validated and is active.
- `INVALID`: Domain validation failed (check status_code for details).
- `DELETING`: Domain is being deleted. ||
|| status_code | **string**

Optional code providing details about validation errors. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of domain creation. ||
|| validated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the domain was successfully validated.
Not set if validation hasn't been completed. ||
|| challenges[] | **[DomainChallenge](#yandex.cloud.organizationmanager.v1.saml.DomainChallenge)**

List of challenges to confirm domain ownership. ||
|#

## DomainChallenge {#yandex.cloud.organizationmanager.v1.saml.DomainChallenge}

A domain validation challenge.

#|
||Field | Description ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of challenge creation. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last challenge status update. ||
|| type | enum **Type**

Type of the validation challenge.

- `TYPE_UNSPECIFIED`
- `DNS_TXT`: DNS TXT record validation method. ||
|| status | enum **Status**

Current status of the challenge.

- `STATUS_UNSPECIFIED`
- `PENDING`: Challenge is awaiting completion.
- `PROCESSING`: Challenge verification is in progress.
- `VALID`: Challenge has been completed successfully.
- `INVALID`: Challenge verification failed. ||
|| dns_challenge | **[DnsRecord](#yandex.cloud.organizationmanager.v1.saml.DomainChallenge.DnsRecord)**

DNS record configuration for domain verification.

Includes only one of the fields `dns_challenge`.

Validation challenge payload. Currently supports only DNS records. ||
|#

## DnsRecord {#yandex.cloud.organizationmanager.v1.saml.DomainChallenge.DnsRecord}

DNS record data for validation challenges.

#|
||Field | Description ||
|| name | **string**

Fully qualified domain name for the record. ||
|| type | enum **Type**

DNS record type (always TXT for current implementation).

- `TYPE_UNSPECIFIED`
- `TXT`: TXT record type. ||
|| value | **string**

Value to set in the DNS record for verification. ||
|#