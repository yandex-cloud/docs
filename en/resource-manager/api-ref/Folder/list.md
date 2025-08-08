---
editable: false
apiPlayground:
  - url: https://resource-manager.{{ api-host }}/resource-manager/v1/folders
    method: get
    path: null
    query:
      type: object
      properties:
        cloudId:
          description: |-
            **string**
            Required field. ID of the cloud to list folders in.
            To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListFoldersResponse.nextPageToken](/docs/resource-manager/api-ref/Folder/list#yandex.cloud.resourcemanager.v1.ListFoldersResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `pageToken`
            to the [ListFoldersResponse.nextPageToken](/docs/resource-manager/api-ref/Folder/list#yandex.cloud.resourcemanager.v1.ListFoldersResponse)
            returned by a previous list request to get the next page of results.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on the [Folder.name](/docs/resource-manager/api-ref/Folder/get#yandex.cloud.resourcemanager.v1.Folder) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
      required:
        - cloudId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/resourcemanager/v1/api-ref/Folder/list.md
---

# Resource Manager API, REST: Folder.List

Retrieves the list of Folder resources in the specified cloud.

## HTTP request

```
GET https://resource-manager.{{ api-host }}/resource-manager/v1/folders
```

## Query parameters {#yandex.cloud.resourcemanager.v1.ListFoldersRequest}

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the cloud to list folders in.
To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListFoldersResponse.nextPageToken](#yandex.cloud.resourcemanager.v1.ListFoldersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListFoldersResponse.nextPageToken](#yandex.cloud.resourcemanager.v1.ListFoldersResponse)
returned by a previous list request to get the next page of results. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Folder.name](#yandex.cloud.resourcemanager.v1.Folder) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## Response {#yandex.cloud.resourcemanager.v1.ListFoldersResponse}

**HTTP Code: 200 - OK**

```json
{
  "folders": [
    {
      "id": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| folders[] | **[Folder](#yandex.cloud.resourcemanager.v1.Folder)**

List of Folder resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFoldersRequest.pageSize](#yandex.cloud.resourcemanager.v1.ListFoldersRequest), use
the `nextPageToken` as the value
for the [ListFoldersRequest.pageToken](#yandex.cloud.resourcemanager.v1.ListFoldersRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Folder {#yandex.cloud.resourcemanager.v1.Folder}

A Folder resource. For more information, see [Folder](/docs/resource-manager/concepts/resources-hierarchy#folder).

#|
||Field | Description ||
|| id | **string**

ID of the folder. ||
|| cloudId | **string**

ID of the cloud that the folder belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the folder.
The name is unique within the cloud. 3-63 characters long. ||
|| description | **string**

Description of the folder. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| status | **enum** (Status)

Status of the folder.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The folder is active.
- `DELETING`: The folder is being deleted.
- `PENDING_DELETION`: Stopping folder resources and waiting for the deletion start timestamp. ||
|#