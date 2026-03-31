---
editable: false
---

# Identity Hub API, gRPC: MfaEnforcementService.ListExcludedAudience

returns specified MFA enforcement's excluded audience

## gRPC request

**rpc ListExcludedAudience ([ListExcludedAudienceRequest](#yandex.cloud.organizationmanager.v1.ListExcludedAudienceRequest)) returns ([ListExcludedAudienceResponse](#yandex.cloud.organizationmanager.v1.ListExcludedAudienceResponse))**

## ListExcludedAudienceRequest {#yandex.cloud.organizationmanager.v1.ListExcludedAudienceRequest}

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

## ListExcludedAudienceResponse {#yandex.cloud.organizationmanager.v1.ListExcludedAudienceResponse}

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
|| subjects[] | **[Subject](#yandex.cloud.organizationmanager.v1.ListExcludedAudienceResponse.Subject)**

MFA enforcement's audience ||
|| next_page_token | **string**

token to get the next page of results ||
|#

## Subject {#yandex.cloud.organizationmanager.v1.ListExcludedAudienceResponse.Subject}

#|
||Field | Description ||
|| id | **string**

subject id ||
|| type | **string**

subject type ||
|#