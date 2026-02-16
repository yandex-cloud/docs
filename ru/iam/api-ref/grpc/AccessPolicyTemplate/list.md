---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/AccessPolicyTemplate/list.md
---

# Identity and Access Management API, gRPC: AccessPolicyTemplateService.List

Returns list of available access policy templates.

## gRPC request

**rpc List ([ListAccessPolicyTemplatesRequest](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesRequest)) returns ([ListAccessPolicyTemplatesResponse](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesResponse))**

## ListAccessPolicyTemplatesRequest {#yandex.cloud.iam.v1.ListAccessPolicyTemplatesRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListAccessPolicyTemplatesResponse.next_page_token](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListAccessPolicyTemplatesResponse.next_page_token](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesResponse) returned by a previous list request.

The maximum string length in characters is 2000. ||
|#

## ListAccessPolicyTemplatesResponse {#yandex.cloud.iam.v1.ListAccessPolicyTemplatesResponse}

```json
{
  "access_policy_templates": [
    {
      "id": "string",
      "name": "string",
      "description": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| access_policy_templates[] | **[AccessPolicy](#yandex.cloud.access.AccessPolicy)**

List of available access policy templates. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListAccessPolicyTemplatesRequest.page_size](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesRequest), use the `next_page_token` as the value
for the [ListAccessPolicyTemplatesRequest.page_token](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## AccessPolicy {#yandex.cloud.access.AccessPolicy}

#|
||Field | Description ||
|| id | **string**

ID of the access policy template. ||
|| name | **string**

Name of the access policy template. ||
|| description | **string**

Description of the access policy template. ||
|#