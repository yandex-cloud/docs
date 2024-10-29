---
editable: false
sourcePath: en/_api-ref/serverless/containers/v1/containers/api-ref/Container/list.md
---

# Serverless Containers Service, REST: Container.List {#List}

Retrieves the list of containers in the specified folder.

## HTTP request

```
GET https://serverless-containers.{{ api-host }}/containers/v1/containers
```

## Query parameters {#yandex.cloud.serverless.containers.v1.ListContainersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list containers in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListContainersResponse.nextPageToken](#yandex.cloud.serverless.containers.v1.ListContainersResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListContainersResponse.nextPageToken](#yandex.cloud.serverless.containers.v1.ListContainersResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters containers listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to the [Container.name](#yandex.cloud.serverless.containers.v1.Container) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name="my-container"`. ||
|#

## Response {#yandex.cloud.serverless.containers.v1.ListContainersResponse}

**HTTP Code: 200 - OK**

```json
{
  "containers": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
      "url": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| containers[] | **[Container](#yandex.cloud.serverless.containers.v1.Container)**

List of containers in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListContainersRequest.pageSize](#yandex.cloud.serverless.containers.v1.ListContainersRequest), use `nextPageToken` as the value
for the [ListContainersRequest.pageToken](#yandex.cloud.serverless.containers.v1.ListContainersRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## Container {#yandex.cloud.serverless.containers.v1.Container}

#|
||Field | Description ||
|| id | **string**

ID of the container. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the container belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp for the container.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the container. The name is unique within the folder. ||
|| description | **string**

Description of the container. ||
|| labels | **string**

Container labels as `key:value` pairs. ||
|| url | **string**

URL that needs to be requested to call the container. ||
|| status | **enum** (Status)

Status of the container.

- `STATUS_UNSPECIFIED`
- `CREATING`: Container is being created.
- `ACTIVE`: Container is ready for use.
- `DELETING`: Container is being deleted.
- `ERROR`: Container failed. The only allowed action is delete. ||
|#