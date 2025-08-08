---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/saml/api-ref/grpc/Federation/listDomains.md
---

# SAML Federation API, gRPC: FederationService.ListDomains

Retrieves the list of domains in the specified federation.

## gRPC request

**rpc ListDomains ([ListFederationDomainsRequest](#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsRequest)) returns ([ListFederationDomainsResponse](#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsResponse))**

## ListFederationDomainsRequest {#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsRequest}

```json
{
  "federation_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| federation_id | **string**

Required field. ID of the federation to list domains for.
To get the federation ID, make a [FederationService.List](/docs/organization/saml/api-ref/grpc/Federation/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListFederationDomainsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListFederationDomainsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression supports the following operations:
- `=` for exact match: `domain = 'domain-1.com'`
- `IN` for multiple values: `status IN ('NEED_TO_VALIDATE', 'VALID')`
- `contains` for domain substring search: `domain contains '3'`
- `AND` for combining conditions: `status = 'INVALID' AND domain contains '3'`

Available fields for filtering:
- `domain` - domain name
- `status` - domain validation status

Must be 1-1000 characters long. ||
|#

## ListFederationDomainsResponse {#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsResponse}

```json
{
  "domains": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| domains[] | **[Domain](#yandex.cloud.organizationmanager.v1.saml.Domain)**

List of domains for the specified federation. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederationDomainsRequest.page_size](#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsRequest), use the `next_page_token` as the value
for the [ListFederationDomainsRequest.page_token](#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
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