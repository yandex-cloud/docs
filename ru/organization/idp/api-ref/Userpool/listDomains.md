---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/userpools/{userpoolId}/domains
    method: get
    path:
      type: object
      properties:
        userpoolId:
          description: |-
            **string**
            ID of the userpool to list domains for.
          type: string
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for pagination.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/api-ref/Userpool/listDomains.md
---

# Identity Provider API, REST: Userpool.ListDomains

Lists domains for the specified userpool.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/userpools/{userpoolId}/domains
```

## Path parameters

Request to list domains for a userpool.

#|
||Field | Description ||
|| userpoolId | **string**

Required field. ID of the userpool to list domains for. ||
|#

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.ListUserpoolDomainsRequest}

Request to list domains for a userpool.

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. ||
|| pageToken | **string**

Page token for pagination. ||
|| filter | **string**

A filter expression that filters resources listed in the response. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.ListUserpoolDomainsResponse}

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
      ],
      "deletionProtection": "boolean"
    }
  ],
  "nextPageToken": "string"
}
```

Response message for [UserpoolService.ListDomains](#ListDomains).

#|
||Field | Description ||
|| domains[] | **[Domain](#yandex.cloud.organizationmanager.v1.idp.Domain)**

List of domains. ||
|| nextPageToken | **string**

Token for getting the next page of the list. ||
|#

## Domain {#yandex.cloud.organizationmanager.v1.idp.Domain}

A domain associated with a userpool.

#|
||Field | Description ||
|| domain | **string**

Domain name. ||
|| status | **enum** (Status)

Current status of the domain.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `NEED_TO_VALIDATE`: The domain needs to be validated.
- `VALIDATING`: The domain is in the process of being validated.
- `VALID`: The domain has been successfully validated.
- `INVALID`: The domain validation has failed.
- `DELETING`: The domain is in the process of being deleted. ||
|| statusCode | **string**

Optional code providing details about validation errors. ||
|| createdAt | **string** (date-time)

Timestamp when the domain was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| validatedAt | **string** (date-time)

Timestamp when the domain was validated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| challenges[] | **[DomainChallenge](#yandex.cloud.organizationmanager.v1.idp.DomainChallenge)**

List of challenges associated with this domain. ||
|| deletionProtection | **boolean**

Whether the domain is protected from deletion. ||
|#

## DomainChallenge {#yandex.cloud.organizationmanager.v1.idp.DomainChallenge}

A challenge used to validate domain ownership.

#|
||Field | Description ||
|| createdAt | **string** (date-time)

Timestamp when the challenge was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp when the challenge was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| type | **enum** (Type)

Type of the challenge.

- `TYPE_UNSPECIFIED`: The type is not specified.
- `DNS_TXT`: DNS TXT record challenge. ||
|| status | **enum** (Status)

Current status of the challenge.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `PENDING`: The challenge is pending verification.
- `PROCESSING`: The challenge verification is in progress.
- `VALID`: The challenge has been successfully verified.
- `INVALID`: The challenge verification has failed. ||
|| dnsChallenge | **[DnsRecord](#yandex.cloud.organizationmanager.v1.idp.DomainChallenge.DnsRecord)**

DNS record challenge details.

Includes only one of the fields `dnsChallenge`.

Challenge details. ||
|#

## DnsRecord {#yandex.cloud.organizationmanager.v1.idp.DomainChallenge.DnsRecord}

DNS record information for domain validation.

#|
||Field | Description ||
|| name | **string**

Name of the DNS record. ||
|| type | **enum** (Type)

Type of the DNS record.

- `TYPE_UNSPECIFIED`: The type is not specified.
- `TXT`: TXT record type. ||
|| value | **string**

Value of the DNS record. ||
|#