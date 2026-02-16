---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/DesktopGroup/listDesktops.md
---

# Cloud Desktop API, gRPC: DesktopGroupService.ListDesktops

Retrieves the list of desktops resources.

## gRPC request

**rpc ListDesktops ([ListDesktopGroupDesktopsRequest](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsRequest)) returns ([ListDesktopGroupDesktopsResponse](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsResponse))**

## ListDesktopGroupDesktopsRequest {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsRequest}

```json
{
  "desktop_group_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| desktop_group_id | **string**

Required field. ID of the desktop group.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListDesktopGroupDesktopsResponse.next_page_token](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDesktopGroupDesktopsResponse.next_page_token](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsResponse) returned by a previous list request.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Desktop.name](#yandex.cloud.clouddesktop.v1.api.Desktop) field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. Value or a list of values to compare against the values of the field.

The maximum string length in characters is 1000. ||
|| order_by | **string**

Sorting the list by [Desktop.name](#yandex.cloud.clouddesktop.v1.api.Desktop), [Desktop.created_at](#yandex.cloud.clouddesktop.v1.api.Desktop) and [Desktop.status](#yandex.cloud.clouddesktop.v1.api.Desktop) fields.
The default sorting order is ascending.

The maximum string length in characters is 100. ||
|#

## ListDesktopGroupDesktopsResponse {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsResponse}

```json
{
  "desktops": [
    {
      "id": "string",
      "folder_id": "string",
      "desktop_group_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "status": "Status",
      "name": "string",
      "resources": {
        "memory": "int64",
        "cores": "int64",
        "core_fraction": "int64"
      },
      "network_interfaces": [
        {
          "network_id": "string",
          "subnet_id": "string"
        }
      ],
      "users": [
        {
          "subject_id": "string",
          "subject_type": "string"
        }
      ],
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| desktops[] | **[Desktop](#yandex.cloud.clouddesktop.v1.api.Desktop)**

List of desktops. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDesktopGroupDesktopsRequest.page_size](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupDesktopsRequest), use
the `next_page_token` as the value
for the [ListDesktopsDGS Request.page_token] query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Desktop {#yandex.cloud.clouddesktop.v1.api.Desktop}

A desktop resource.

#|
||Field | Description ||
|| id | **string**

Desktop ID. ||
|| folder_id | **string**

ID of the folder that the desktop belongs to. ||
|| desktop_group_id | **string**

ID of the desktop group that the desktop belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| status | enum **Status**

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
|| network_interfaces[] | **[NetworkInterface](#yandex.cloud.clouddesktop.v1.api.NetworkInterface)** ||
|| users[] | **[User](#yandex.cloud.clouddesktop.v1.api.User)** ||
|| labels | **object** (map<**string**, **string**>)

Labels of the desktop. ||
|#

## Resources {#yandex.cloud.clouddesktop.v1.api.Resources}

#|
||Field | Description ||
|| memory | **int64**

The minimum value is 1. ||
|| cores | **int64**

The minimum value is 1. ||
|| core_fraction | **int64**

Acceptable values are 0 to 100, inclusive. ||
|#

## NetworkInterface {#yandex.cloud.clouddesktop.v1.api.NetworkInterface}

#|
||Field | Description ||
|| network_id | **string**

Required field.

The maximum string length in characters is 50. ||
|| subnet_id | **string**

Required field.

The maximum string length in characters is 50. ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subject_id | **string**

Required field. Identity of the access binding.

The maximum string length in characters is 100. ||
|| subject_type | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system.

The maximum string length in characters is 100. ||
|#