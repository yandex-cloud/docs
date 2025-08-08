---
editable: false
apiPlayground:
  - url: https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListCloudsResponse.nextPageToken](/docs/resource-manager/api-ref/Cloud/list#yandex.cloud.resourcemanager.v1.ListCloudsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `pageToken`
            to the [ListCloudsResponse.nextPageToken](/docs/resource-manager/api-ref/Cloud/list#yandex.cloud.resourcemanager.v1.ListCloudsResponse)
            returned by a previous list request to get the next page of results.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on the [Cloud.name](/docs/resource-manager/api-ref/Cloud/get#yandex.cloud.resourcemanager.v1.Cloud) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
        organizationId:
          description: |-
            **string**
            ID of the organization to list clouds in.
            To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/Organization/list#List) request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/resourcemanager/v1/api-ref/Cloud/list.md
---

# Resource Manager API, REST: Cloud.List

Retrieves the list of Cloud resources.

## HTTP request

```
GET https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
```

## Query parameters {#yandex.cloud.resourcemanager.v1.ListCloudsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListCloudsResponse.nextPageToken](#yandex.cloud.resourcemanager.v1.ListCloudsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListCloudsResponse.nextPageToken](#yandex.cloud.resourcemanager.v1.ListCloudsResponse)
returned by a previous list request to get the next page of results. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Cloud.name](#yandex.cloud.resourcemanager.v1.Cloud) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| organizationId | **string**

ID of the organization to list clouds in.
To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/Organization/list#List) request. ||
|#

## Response {#yandex.cloud.resourcemanager.v1.ListCloudsResponse}

**HTTP Code: 200 - OK**

```json
{
  "clouds": [
    {
      "id": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "organizationId": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clouds[] | **[Cloud](#yandex.cloud.resourcemanager.v1.Cloud)**

List of Cloud resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListCloudsRequest.pageSize](#yandex.cloud.resourcemanager.v1.ListCloudsRequest), use
the `nextPageToken` as the value
for the [ListCloudsRequest.pageToken](#yandex.cloud.resourcemanager.v1.ListCloudsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Cloud {#yandex.cloud.resourcemanager.v1.Cloud}

A Cloud resource. For more information, see [Cloud](/docs/resource-manager/concepts/resources-hierarchy#cloud).

#|
||Field | Description ||
|| id | **string**

ID of the cloud. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the cloud. 3-63 characters long. ||
|| description | **string**

Description of the cloud. 0-256 characters long. ||
|| organizationId | **string**

ID of the organization that the cloud belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#