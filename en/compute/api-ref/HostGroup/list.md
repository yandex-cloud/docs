---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/HostGroup/list.md
---

# Compute Cloud API, REST: HostGroup.List

Retrieves the list of host groups in the specified folder.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/hostGroups
```

## Query parameters {#yandex.cloud.compute.v1.ListHostGroupsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list host groups in.
To get the folder ID, use [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListHostGroupsResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostGroupsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListHostGroupsResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostGroupsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`.
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
The default sorting order is ascending ||
|#

## Response {#yandex.cloud.compute.v1.ListHostGroupsResponse}

**HTTP Code: 200 - OK**

```json
{
  "hostGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "zoneId": "string",
      "status": "string",
      "typeId": "string",
      "maintenancePolicy": "string",
      "scalePolicy": {
        // Includes only one of the fields `fixedScale`
        "fixedScale": {
          "size": "string"
        }
        // end of the list of possible fields
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hostGroups[] | **[HostGroup](#yandex.cloud.compute.v1.HostGroup)**

Lists host groups for the specified folder. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListHostGroupsRequest.pageSize](#yandex.cloud.compute.v1.ListHostGroupsRequest), use
`nextPageToken` as the value
for the [ListHostGroupsRequest.pageToken](#yandex.cloud.compute.v1.ListHostGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## HostGroup {#yandex.cloud.compute.v1.HostGroup}

Represents group of dedicated hosts

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| folderId | **string**

ID of the folder that the group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the group. The name is unique within the folder. ||
|| description | **string**

Description of the group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| zoneId | **string**

Availability zone where all dedicated hosts are allocated. ||
|| status | **enum** (Status)

Status of the group.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `READY`
- `UPDATING`
- `DELETING` ||
|| typeId | **string**

ID of host type. Resources provided by each host of the group. ||
|| maintenancePolicy | **enum** (MaintenancePolicy)

Behaviour on maintenance events.

- `MAINTENANCE_POLICY_UNSPECIFIED`
- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.compute.v1.ScalePolicy)**

Scale policy. Only fixed number of hosts are supported at this moment. ||
|#

## ScalePolicy {#yandex.cloud.compute.v1.ScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.compute.v1.ScalePolicy.FixedScale)**

Includes only one of the fields `fixedScale`. ||
|#

## FixedScale {#yandex.cloud.compute.v1.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64) ||
|#