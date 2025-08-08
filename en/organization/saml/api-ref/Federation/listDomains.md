---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}/domains
    method: get
    path:
      type: object
      properties:
        federationId:
          description: |-
            **string**
            Required field. ID of the federation to list domains for.
            To get the federation ID, make a [FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request.
          type: string
      required:
        - federationId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListFederationDomainsResponse.nextPageToken](/docs/organization/saml/api-ref/Federation/listDomains#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListFederationDomainsResponse.nextPageToken](/docs/organization/saml/api-ref/Federation/listDomains#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsResponse)
            returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression supports the following operations:
            - `=` for exact match: `domain = 'domain-1.com'`
            - `IN` for multiple values: `status IN ('NEED_TO_VALIDATE', 'VALID')`
            - `contains` for domain substring search: `domain contains '3'`
            - `AND` for combining conditions: `status = 'INVALID' AND domain contains '3'`
            Available fields for filtering:
            - `domain` - domain name
            - `status` - domain validation status
            Must be 1-1000 characters long.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/saml/api-ref/Federation/listDomains.md
---

# SAML Federation API, REST: Federation.ListDomains

Retrieves the list of domains in the specified federation.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}/domains
```

## Path parameters

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation to list domains for.
To get the federation ID, make a [FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request. ||
|#

## Query parameters {#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListFederationDomainsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListFederationDomainsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsResponse)
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

## Response {#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsResponse}

**HTTP Code: 200 - OK**

```json
{
  "domains": [
    {
      "domain": "string",
      "status": "string",
      "statusCode": "string",
      "createdAt": "string",
      "validatedAt": "string",
      "challenges": [
        {
          "createdAt": "string",
          "updatedAt": "string",
          "type": "string",
          "status": "string",
          // Includes only one of the fields `dnsChallenge`
          "dnsChallenge": {
            "name": "string",
            "type": "string",
            "value": "string"
          }
          // end of the list of possible fields
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| domains[] | **[Domain](#yandex.cloud.organizationmanager.v1.saml.Domain)**

List of domains for the specified federation. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederationDomainsRequest.pageSize](#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsRequest), use the `nextPageToken` as the value
for the [ListFederationDomainsRequest.pageToken](#yandex.cloud.organizationmanager.v1.saml.ListFederationDomainsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Domain {#yandex.cloud.organizationmanager.v1.saml.Domain}

A domain.

#|
||Field | Description ||
|| domain | **string**

Domain name ||
|| status | **enum** (Status)

Current status of the domain.

- `STATUS_UNSPECIFIED`
- `NEED_TO_VALIDATE`: Domain requires ownership validation.
- `VALIDATING`: Domain validation is in progress.
- `VALID`: Domain has been successfully validated and is active.
- `INVALID`: Domain validation failed (check status_code for details).
- `DELETING`: Domain is being deleted. ||
|| statusCode | **string**

Optional code providing details about validation errors. ||
|| createdAt | **string** (date-time)

Timestamp of domain creation.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| validatedAt | **string** (date-time)

Timestamp when the domain was successfully validated.
Not set if validation hasn't been completed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| challenges[] | **[DomainChallenge](#yandex.cloud.organizationmanager.v1.saml.DomainChallenge)**

List of challenges to confirm domain ownership. ||
|#

## DomainChallenge {#yandex.cloud.organizationmanager.v1.saml.DomainChallenge}

A domain validation challenge.

#|
||Field | Description ||
|| createdAt | **string** (date-time)

Timestamp of challenge creation.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last challenge status update.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| type | **enum** (Type)

Type of the validation challenge.

- `TYPE_UNSPECIFIED`
- `DNS_TXT`: DNS TXT record validation method. ||
|| status | **enum** (Status)

Current status of the challenge.

- `STATUS_UNSPECIFIED`
- `PENDING`: Challenge is awaiting completion.
- `PROCESSING`: Challenge verification is in progress.
- `VALID`: Challenge has been completed successfully.
- `INVALID`: Challenge verification failed. ||
|| dnsChallenge | **[DnsRecord](#yandex.cloud.organizationmanager.v1.saml.DomainChallenge.DnsRecord)**

DNS record configuration for domain verification.

Includes only one of the fields `dnsChallenge`.

Validation challenge payload. Currently supports only DNS records. ||
|#

## DnsRecord {#yandex.cloud.organizationmanager.v1.saml.DomainChallenge.DnsRecord}

DNS record data for validation challenges.

#|
||Field | Description ||
|| name | **string**

Fully qualified domain name for the record. ||
|| type | **enum** (Type)

DNS record type (always TXT for current implementation).

- `TYPE_UNSPECIFIED`
- `TXT`: TXT record type. ||
|| value | **string**

Value to set in the DNS record for verification. ||
|#