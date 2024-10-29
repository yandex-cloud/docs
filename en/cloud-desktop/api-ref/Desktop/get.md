---
editable: false
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/Desktop/get.md
---

# Cloud Desktop API, REST: Desktop.Get {#Get}

Returns the specified desktop resource.

To get the list of available desktops, make a [List](/docs/cloud-desktop/api-ref/Desktop/list#List) request.

## HTTP request

```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktops/{desktopId}
```

## Path parameters

#|
||Field | Description ||
|| desktopId | **string**

Required field. ID of the desktop resource to return.

To get the desktop ID use a [DesktopService.List](/docs/cloud-desktop/api-ref/Desktop/list#List) request. ||
|#

## Response {#yandex.cloud.clouddesktop.v1.api.Desktop}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "desktopGroupId": "string",
  "createdAt": "string",
  "status": "string",
  "name": "string",
  "resources": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "networkInterfaces": [
    {
      "networkId": "string",
      "subnetId": "string"
    }
  ],
  "users": [
    {
      "subjectId": "string",
      "subjectType": "string"
    }
  ]
}
```

A desktop resource.

#|
||Field | Description ||
|| id | **string**

Desktop ID. ||
|| folderId | **string**

ID of the folder that the desktop belongs to. ||
|| desktopGroupId | **string**

ID of the desktop group that the desktop belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Status of the desktop.

- `STATUS_UNSPECIFIED`
- `CREATING`: Desktop is being created.
- `ACTIVE`: Desktop is ready to use.
- `DELETING`: Desktop is being deleted. ||
|| name | **string**

Name of the desktop. ||
|| resources | **[Resources](#yandex.cloud.clouddesktop.v1.api.Resources)**

Resources of the desktop. ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.clouddesktop.v1.api.NetworkInterface)** ||
|| users[] | **[User](#yandex.cloud.clouddesktop.v1.api.User)** ||
|#

## Resources {#yandex.cloud.clouddesktop.v1.api.Resources}

#|
||Field | Description ||
|| memory | **string** (int64) ||
|| cores | **string** (int64) ||
|| coreFraction | **string** (int64) ||
|#

## NetworkInterface {#yandex.cloud.clouddesktop.v1.api.NetworkInterface}

#|
||Field | Description ||
|| networkId | **string**

Required field.  ||
|| subnetId | **string**

Required field.  ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subjectId | **string**

Required field. Identity of the access binding. ||
|| subjectType | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system. ||
|#