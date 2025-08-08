---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/Userpool/getDomain.md
---

# Identity Provider API, gRPC: UserpoolService.GetDomain

Returns the specified domain for a userpool.

## gRPC request

**rpc GetDomain ([GetUserpoolDomainRequest](#yandex.cloud.organizationmanager.v1.idp.GetUserpoolDomainRequest)) returns ([Domain](#yandex.cloud.organizationmanager.v1.idp.Domain))**

## GetUserpoolDomainRequest {#yandex.cloud.organizationmanager.v1.idp.GetUserpoolDomainRequest}

```json
{
  "userpool_id": "string",
  "domain": "string"
}
```

Request to get a domain for a userpool.

#|
||Field | Description ||
|| userpool_id | **string**

ID of the userpool to get a domain for. ||
|| domain | **string**

Domain name. ||
|#

## Domain {#yandex.cloud.organizationmanager.v1.idp.Domain}

```json
{
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
```

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