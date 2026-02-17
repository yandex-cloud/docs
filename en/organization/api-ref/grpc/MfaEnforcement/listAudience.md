---
editable: false
---

# Identity Hub API, gRPC: MfaEnforcementService.ListAudience

returns specified MFA enforcement's audience

## gRPC request

**rpc ListAudience ([ListAudienceRequest](#yandex.cloud.organizationmanager.v1.ListAudienceRequest)) returns ([ListAudienceResponse](#yandex.cloud.organizationmanager.v1.ListAudienceResponse))**

## ListAudienceRequest {#yandex.cloud.organizationmanager.v1.ListAudienceRequest}

```json
{
  "mfa_enforcement_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| mfa_enforcement_id | **string**

Required field. id of the MFA enforcement

The maximum string length in characters is 50. ||
|| page_size | **int64**

the maximum number of results per page to return

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

page token

The maximum string length in characters is 2000. ||
|#

## ListAudienceResponse {#yandex.cloud.organizationmanager.v1.ListAudienceResponse}

```json
{
  "subjects": [
    {
      "id": "string",
      "type": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| subjects[] | **[Subject](#yandex.cloud.organizationmanager.v1.ListAudienceResponse.Subject)**

MFA enforcement's audience ||
|| next_page_token | **string**

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