---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/mfaEnforcements/{mfaEnforcementId}:listAudience
    method: get
    path:
      type: object
      properties:
        mfaEnforcementId:
          description: |-
            **string**
            Required field. id of the MFA enforcement
            The maximum string length in characters is 50.
          type: string
      required:
        - mfaEnforcementId
      additionalProperties: false
    query:
      type: object
      properties:
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
      additionalProperties: false
    body: null
    definitions: null
---

# Identity Hub API, REST: MfaEnforcement.ListAudience

returns specified MFA enforcement's audience

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/mfaEnforcements/{mfaEnforcementId}:listAudience
```

## Path parameters

#|
||Field | Description ||
|| mfaEnforcementId | **string**

Required field. id of the MFA enforcement

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.organizationmanager.v1.ListAudienceRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

the maximum number of results per page to return

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

page token

The maximum string length in characters is 2000. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.ListAudienceResponse}

**HTTP Code: 200 - OK**

```json
{
  "subjects": [
    {
      "id": "string",
      "type": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| subjects[] | **[Subject](#yandex.cloud.organizationmanager.v1.ListAudienceResponse.Subject)**

MFA enforcement's audience ||
|| nextPageToken | **string**

token to get the next page of results ||
|#

## Subject {#yandex.cloud.organizationmanager.v1.ListAudienceResponse.Subject}

#|
||Field | Description ||
|| id | **string**

subject id ||
|| type | **string**

subject type ||
|#