---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/HostGroup/get.md
---

# Compute Cloud API, REST: HostGroup.Get

Returns the specified host group.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/hostGroups/{hostGroupId}
```

## Path parameters

#|
||Field | Description ||
|| hostGroupId | **string**

Required field. ID of the host group to return.
To get the host group ID, use [HostGroupService.List](/docs/compute/api-ref/HostGroup/list#List) request. ||
|#

## Response {#yandex.cloud.compute.v1.HostGroup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
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
```

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
|| labels | **string**

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