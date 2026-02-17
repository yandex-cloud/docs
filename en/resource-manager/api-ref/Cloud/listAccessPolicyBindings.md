---
editable: false
apiPlayground:
  - url: https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/{resourceId}:listAccessPolicyBindings
    method: get
    path:
      type: object
      properties:
        resourceId:
          description: |-
            **string**
            Required field. ID of the resource to list access policy bindings for.
            To get the resource ID, use a corresponding List request.
            For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request to get the Cloud resource ID.
            The maximum string length in characters is 50.
          type: string
      required:
        - resourceId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned.
            If the number of available results is larger than `pageSize`, the service returns a
            [ListAccessPolicyBindingsResponse.nextPageToken](#yandex.cloud.access.ListAccessPolicyBindingsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
            Acceptable values are 0 to 1000, inclusive.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `pageToken` to the
            [ListAccessPolicyBindingsResponse.nextPageToken](#yandex.cloud.access.ListAccessPolicyBindingsResponse)
            returned by a previous list request to get the next page of results.
            The maximum string length in characters is 100.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Resource Manager API, REST: Cloud.ListAccessPolicyBindings

Returns list of access policy bindings for the cloud.

## HTTP request

```
GET https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/{resourceId}:listAccessPolicyBindings
```

## Path parameters

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of the resource to list access policy bindings for.

To get the resource ID, use a corresponding List request.
For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request to get the Cloud resource ID.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.access.ListAccessPolicyBindingsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned.
If the number of available results is larger than `pageSize`, the service returns a
[ListAccessPolicyBindingsResponse.nextPageToken](#yandex.cloud.access.ListAccessPolicyBindingsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. Set `pageToken` to the
[ListAccessPolicyBindingsResponse.nextPageToken](#yandex.cloud.access.ListAccessPolicyBindingsResponse)
returned by a previous list request to get the next page of results.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.access.ListAccessPolicyBindingsResponse}

**HTTP Code: 200 - OK**

```json
{
  "accessPolicyBindings": [
    {
      "accessPolicyTemplateId": "string",
      "parameters": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| accessPolicyBindings[] | **[AccessPolicyBinding](#yandex.cloud.access.AccessPolicyBinding)**

List of access policy bindings for the specified resource. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than
[ListAccessPolicyBindingsRequest.pageSize](#yandex.cloud.access.ListAccessPolicyBindingsRequest)
, use the `nextPageToken` as the value for the
[ListAccessPolicyBindingsRequest.pageToken](#yandex.cloud.access.ListAccessPolicyBindingsRequest)
query parameter in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## AccessPolicyBinding {#yandex.cloud.access.AccessPolicyBinding}

#|
||Field | Description ||
|| accessPolicyTemplateId | **string**

Required field. ID of the access policy template being applied.

The maximum string length in characters is 50. ||
|| parameters | **object** (map<**string**, **string**>) ||
|#