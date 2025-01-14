---
editable: false
sourcePath: en/_api-ref/serverless/containers/v1/containers/api-ref/Container/get.md
---

# Serverless Containers Service, REST: Container.Get

Returns the specified container.

To get the list of all available containers, make a [List](/docs/serverless-containers/containers/api-ref/Container/list#List) request.

## HTTP request

```
GET https://serverless-containers.{{ api-host }}/containers/v1/containers/{containerId}
```

## Path parameters

#|
||Field | Description ||
|| containerId | **string**

Required field. ID of the container to return.

To get a container ID make a [ContainerService.List](/docs/serverless-containers/containers/api-ref/Container/list#List) request. ||
|#

## Response {#yandex.cloud.serverless.containers.v1.Container}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "url": "string",
  "status": "string"
}
```

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
|| labels | **object** (map<**string**, **string**>)

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