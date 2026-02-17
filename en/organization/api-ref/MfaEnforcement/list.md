---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/mfaEnforcements
    method: get
    path: null
    query:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. organization id
            The maximum string length in characters is 50.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            the maximum number of results per page to return
            Acceptable values are 0 to 1000, inclusive.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            page token
            The maximum string length in characters is 2000.
          type: string
      required:
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
---

# Identity Hub API, REST: MfaEnforcement.List

returns MFA enforcements for the specified organization

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/mfaEnforcements
```

## Query parameters {#yandex.cloud.organizationmanager.v1.ListMfaEnforcementsRequest}

#|
||Field | Description ||
|| organizationId | **string**

Required field. organization id

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

the maximum number of results per page to return

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

page token

The maximum string length in characters is 2000. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.ListMfaEnforcementsResponse}

**HTTP Code: 200 - OK**

```json
{
  "mfaEnforcements": [
    {
      "id": "string",
      "organizationId": "string",
      "acrId": "string",
      "ttl": "string",
      "status": "string",
      "applyAt": "string",
      "enrollWindow": "string",
      "name": "string",
      "description": "string",
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| mfaEnforcements[] | **[MfaEnforcement](#yandex.cloud.organizationmanager.v1.MfaEnforcement)**

list of MFA enforcements for the specified organization ||
|| nextPageToken | **string**

token to get the next page of results ||
|#

## MfaEnforcement {#yandex.cloud.organizationmanager.v1.MfaEnforcement}

MFA enforcement resource

#|
||Field | Description ||
|| id | **string**

id of the MFA enforcement ||
|| organizationId | **string**

organization id of the MFA enforcement ||
|| acrId | **string**

acr id of the MFA enforcement ||
|| ttl | **string** (duration)

the period during which the entered MFA factor is considered valid and the
corresponding acr is regarded as satisfied ||
|| status | **enum** (MfaEnforcementStatus)

MFA enforcement status

- `MFA_ENFORCEMENT_STATUS_ACTIVE`
- `MFA_ENFORCEMENT_STATUS_INACTIVE`
- `MFA_ENFORCEMENT_STATUS_DELETING` ||
|| applyAt | **string** (date-time)

the MFA enforcement application start time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| enrollWindow | **string** (duration)

the time window during which the user is allowed to create an MFA profile.
this window is measured relative to the MFA enforcement application start time
and the user's most recent successful authentication that falls under the rule
(or the user's creation time, if there has been no authentication). ||
|| name | **string**

name of the MFA enforcement ||
|| description | **string**

description of the MFA enforcement ||
|| createdAt | **string** (date-time)

creation timestamp

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#