---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}/domains/{domain}
    method: get
    path:
      type: object
      properties:
        federationId:
          description: |-
            **string**
            Required field. ID of the federation to get domain information for.
            To get the federation ID, make a [FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request.
          type: string
        domain:
          description: |-
            **string**
            Required field. Domain name to get information for.
            Must be a valid domain name (1-253 characters).
          type: string
      required:
        - federationId
        - domain
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/saml/api-ref/Federation/getDomain.md
---

# SAML Federation API, REST: Federation.GetDomain

Returns the specified domain in the federation.

To get the list of available domains, make a [ListDomains](/docs/organization/saml/api-ref/Federation/listDomains#ListDomains) request.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}/domains/{domain}
```

## Path parameters

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation to get domain information for.
To get the federation ID, make a [FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request. ||
|| domain | **string**

Required field. Domain name to get information for.
Must be a valid domain name (1-253 characters). ||
|#

## Response {#yandex.cloud.organizationmanager.v1.saml.Domain}

**HTTP Code: 200 - OK**

```json
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
```

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