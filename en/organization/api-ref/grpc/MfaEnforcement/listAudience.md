---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/MfaEnforcement/listAudience.md
---

# Identity Hub API, gRPC: MfaEnforcementService.ListAudience

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

Required field.  ||
|| page_size | **int64** ||
|| page_token | **string** ||
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
|| subjects[] | **[Subject](#yandex.cloud.organizationmanager.v1.ListAudienceResponse.Subject)** ||
|| next_page_token | **string** ||
|#

## Subject {#yandex.cloud.organizationmanager.v1.ListAudienceResponse.Subject}

#|
||Field | Description ||
|| id | **string** ||
|| type | **string** ||
|#