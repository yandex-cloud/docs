---
editable: false
sourcePath: en/_api-ref/resourcemanager/v1/api-ref/Folder/get.md
---

# Resource Manager API, REST: Folder.Get

Returns the specified Folder resource.

To get the list of available Folder resources, make a [List](/docs/resource-manager/api-ref/Folder/list#List) request.

## HTTP request

```
GET https://resource-manager.{{ api-host }}/resource-manager/v1/folders/{folderId}
```

## Path parameters

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the Folder resource to return.
To get the folder ID, use a [FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|#

## Response {#yandex.cloud.resourcemanager.v1.Folder}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string"
}
```

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