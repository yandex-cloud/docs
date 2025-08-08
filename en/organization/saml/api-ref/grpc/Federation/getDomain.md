---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/saml/api-ref/grpc/Federation/getDomain.md
---

# SAML Federation API, gRPC: FederationService.GetDomain

Returns the specified domain in the federation.

To get the list of available domains, make a [ListDomains](/docs/organization/saml/api-ref/grpc/Federation/listDomains#ListDomains) request.

## gRPC request

**rpc GetDomain ([GetFederationDomainRequest](#yandex.cloud.organizationmanager.v1.saml.GetFederationDomainRequest)) returns ([Domain](#yandex.cloud.organizationmanager.v1.saml.Domain))**

## GetFederationDomainRequest {#yandex.cloud.organizationmanager.v1.saml.GetFederationDomainRequest}

```json
{
  "federation_id": "string",
  "domain": "string"
}
```

#|
||Field | Description ||
|| federation_id | **string**

Required field. ID of the federation to get domain information for.
To get the federation ID, make a [FederationService.List](/docs/organization/saml/api-ref/grpc/Federation/list#List) request. ||
|| domain | **string**

Required field. Domain name to get information for.
Must be a valid domain name (1-253 characters). ||
|#

## Domain {#yandex.cloud.organizationmanager.v1.saml.Domain}

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
  ]
}
```

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