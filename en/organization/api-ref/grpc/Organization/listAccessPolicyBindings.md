---
editable: false
---

# Identity Hub API, gRPC: OrganizationService.ListAccessPolicyBindings

Returns list of access policy bindings for the organization.

## gRPC request

**rpc ListAccessPolicyBindings ([access.ListAccessPolicyBindingsRequest](#yandex.cloud.access.ListAccessPolicyBindingsRequest)) returns ([access.ListAccessPolicyBindingsResponse](#yandex.cloud.access.ListAccessPolicyBindingsResponse))**

## access.ListAccessPolicyBindingsRequest {#yandex.cloud.access.ListAccessPolicyBindingsRequest}

```json
{
  "resource_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource to list access policy bindings for.

To get the resource ID, use a corresponding List request.
For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request to get the Cloud resource ID.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page that should be returned.
If the number of available results is larger than `page_size`, the service returns a
[ListAccessPolicyBindingsResponse.next_page_token](#yandex.cloud.access.ListAccessPolicyBindingsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. Set `page_token` to the
[ListAccessPolicyBindingsResponse.next_page_token](#yandex.cloud.access.ListAccessPolicyBindingsResponse)
returned by a previous list request to get the next page of results.

The maximum string length in characters is 100. ||
|#

## access.ListAccessPolicyBindingsResponse {#yandex.cloud.access.ListAccessPolicyBindingsResponse}

```json
{
  "access_policy_bindings": [
    {
      "access_policy_template_id": "string",
      "parameters": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| access_policy_bindings[] | **[AccessPolicyBinding](#yandex.cloud.access.AccessPolicyBinding)**

List of access policy bindings for the specified resource. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than
[ListAccessPolicyBindingsRequest.page_size](#yandex.cloud.access.ListAccessPolicyBindingsRequest)
, use the `next_page_token` as the value for the
[ListAccessPolicyBindingsRequest.page_token](#yandex.cloud.access.ListAccessPolicyBindingsRequest)
query parameter in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## AccessPolicyBinding {#yandex.cloud.access.AccessPolicyBinding}

#|
||Field | Description ||
|| access_policy_template_id | **string**

Required field. ID of the access policy template being applied.

The maximum string length in characters is 50. ||
|| parameters | **object** (map<**string**, **string**>) ||
|#