---
editable: false
apiPlayground:
  - url: https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups/{desktopGroupId}/desktops
    method: get
    path:
      type: object
      properties:
        desktopGroupId:
          description: |-
            **string**
            Required field. ID of the desktop group.
            The maximum string length in characters is 50.
          type: string
      required:
        - desktopGroupId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListDesktopGroupDesktopsResponse.nextPageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
            Acceptable values are 0 to 1000, inclusive.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListDesktopGroupDesktopsResponse.nextPageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsResponse) returned by a previous list request.
            The maximum string length in characters is 100.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [Desktop.name](#yandex.cloud.clouddesktop.v1.api.Desktop) field.
            2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
            3. Value or a list of values to compare against the values of the field.
            The maximum string length in characters is 1000.
          type: string
        orderBy:
          description: |-
            **string**
            Sorting the list by [Desktop.name](#yandex.cloud.clouddesktop.v1.api.Desktop), [Desktop.createdAt](#yandex.cloud.clouddesktop.v1.api.Desktop) and [Desktop.status](#yandex.cloud.clouddesktop.v1.api.Desktop) fields.
            The default sorting order is ascending.
            The maximum string length in characters is 100.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/DesktopGroup/listDesktops.md
---

# Cloud Desktop API, REST: DesktopGroup.ListDesktops

Retrieves the list of desktops resources.

## HTTP request

```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups/{desktopGroupId}/desktops
```

## Path parameters

#|
||Field | Description ||
|| desktopGroupId | **string**

Required field. ID of the desktop group.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListDesktopGroupDesktopsResponse.nextPageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListDesktopGroupDesktopsResponse.nextPageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsResponse) returned by a previous list request.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Desktop.name](#yandex.cloud.clouddesktop.v1.api.Desktop) field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. Value or a list of values to compare against the values of the field.

The maximum string length in characters is 1000. ||
|| orderBy | **string**

Sorting the list by [Desktop.name](#yandex.cloud.clouddesktop.v1.api.Desktop), [Desktop.createdAt](#yandex.cloud.clouddesktop.v1.api.Desktop) and [Desktop.status](#yandex.cloud.clouddesktop.v1.api.Desktop) fields.
The default sorting order is ascending.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsResponse}

**HTTP Code: 200 - OK**

```json
{
  "desktops": [
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
      ],
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| desktops[] | **[Desktop](#yandex.cloud.clouddesktop.v1.api.Desktop)**

List of desktops. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDesktopGroupDesktopsRequest.pageSize](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsRequest), use
the `nextPageToken` as the value
for the [ListDesktopsDGS Request.page_token] query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Desktop {#yandex.cloud.clouddesktop.v1.api.Desktop}

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

- `CREATING`: Desktop is being created.
- `ACTIVE`: Desktop is ready to be used.
- `DELETING`: Desktop is being deleted.
- `RESTARTING`: Desktop is restarting.
- `UPDATING`: Desktop is updating.
- `STARTING`: Desktop is starting.
- `STOPPING`: Desktop is stopping.
- `STOPPED`: Desktop is stopped.
- `ERROR`: Desktop did not manage start or restart.
- `CREATION_FAILED`: Desktop did not manage to get created or updated.
- `HEALTH_CHECK`: Desktop in the process of health check. ||
|| name | **string**

Name of the desktop. ||
|| resources | **[Resources](#yandex.cloud.clouddesktop.v1.api.Resources)**

Resources of the desktop. ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.clouddesktop.v1.api.NetworkInterface)** ||
|| users[] | **[User](#yandex.cloud.clouddesktop.v1.api.User)** ||
|| labels | **object** (map<**string**, **string**>)

Labels of the desktop. ||
|#

## Resources {#yandex.cloud.clouddesktop.v1.api.Resources}

#|
||Field | Description ||
|| memory | **string** (int64)

The minimum value is 1. ||
|| cores | **string** (int64)

The minimum value is 1. ||
|| coreFraction | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|#

## NetworkInterface {#yandex.cloud.clouddesktop.v1.api.NetworkInterface}

#|
||Field | Description ||
|| networkId | **string**

Required field.

The maximum string length in characters is 50. ||
|| subnetId | **string**

Required field.

The maximum string length in characters is 50. ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subjectId | **string**

Required field. Identity of the access binding.

The maximum string length in characters is 100. ||
|| subjectType | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system.

The maximum string length in characters is 100. ||
|#