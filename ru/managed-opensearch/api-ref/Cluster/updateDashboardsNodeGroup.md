---
editable: false
apiPlayground:
  - '{"url":"https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/dashboards/node_groups/{name}","method":"patch","path":{"type":"object","properties":{"clusterId":{"description":"**string**\n\nRequired field. ID of the OpenSearch cluster to update the Dashboards type host group in.","type":"string"},"name":{"description":"**string**\n\nRequired field. Name of the Dashboards type host group to be updated.","pattern":"[a-zA-Z0-9_-]*","type":"string"}},"required":["clusterId","name"],"additionalProperties":false},"query":null,"body":{"type":"object","properties":{"updateMask":{"description":"**string** (field-mask)\n\nA comma-separated names off ALL fields to be updated.\nOnly the specified fields will be changed. The others will be left untouched.\nIf the field is specified in `` updateMask `` and no value for that field was sent in the request,\nthe field''s value will be reset to the default. The default value for most fields is null or 0.\n\nIf `` updateMask `` is not sent in the request, all fields'' values will be updated.\nFields specified in the request will be updated to provided values.\nThe rest of the fields will be reset to the default.","type":"string","format":"field-mask"},"nodeGroupSpec":{"description":"**[DashboardsNodeGroupUpdateSpec](/docs/managed-opensearch/api-ref/Cluster/updateDashboardsNodeGroup#yandex.cloud.mdb.opensearch.v1.DashboardsNodeGroupUpdateSpec)**\n\nNew configuration for the host group.","$ref":"#/definitions/DashboardsNodeGroupUpdateSpec"}},"additionalProperties":false},"definitions":{"Resources":{"type":"object","properties":{"resourcePresetId":{"description":"**string**\n\nID of the preset for computational resources allocated to a host.","type":"string"},"diskSize":{"description":"**string** (int64)\n\nVolume of the storage used by the host, in bytes.","type":"string","format":"int64"},"diskTypeId":{"description":"**string**\n\nType of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`.","type":"string"}}},"DiskSizeAutoscaling":{"type":"object","properties":{"plannedUsageThreshold":{"description":"**string** (int64)\n\nAmount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.","type":"string","format":"int64"},"emergencyUsageThreshold":{"description":"**string** (int64)\n\nAmount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.","type":"string","format":"int64"},"diskSizeLimit":{"description":"**string** (int64)\n\nLimit on how large the storage for database instances can automatically grow, in bytes.","type":"string","format":"int64"}}},"DashboardsNodeGroupUpdateSpec":{"type":"object","properties":{"resources":{"description":"**[Resources](/docs/managed-opensearch/api-ref/Cluster/get#yandex.cloud.mdb.opensearch.v1.Resources)**\n\nResources allocated to the hosts.","$ref":"#/definitions/Resources"},"hostsCount":{"description":"**string** (int64)\n\nNumber of hosts in the group.","type":"string","format":"int64"},"zoneIds":{"description":"**string**\n\nIDs of the availability zones for hosts","type":"array","items":{"type":"string"}},"subnetIds":{"description":"**string**\n\nIDs of the subnets for hosts","type":"array","items":{"type":"string"}},"assignPublicIp":{"description":"**boolean**\n\nWhether the hosts should get a public IP address.","type":"boolean"},"diskSizeAutoscaling":{"description":"**[DiskSizeAutoscaling](/docs/managed-opensearch/api-ref/Cluster/get#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**\n\nDisk size autoscaling settings","$ref":"#/definitions/DiskSizeAutoscaling"}}}}}'
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Cluster/updateDashboardsNodeGroup.md
---

# Managed Service for OpenSearch API, REST: Cluster.UpdateDashboardsNodeGroup

Updates a Dashboards type host group.

## HTTP request

```
PATCH https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/dashboards/node_groups/{name}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the OpenSearch cluster to update the Dashboards type host group in. ||
|| name | **string**

Required field. Name of the Dashboards type host group to be updated. ||
|#

## Body parameters {#yandex.cloud.mdb.opensearch.v1.UpdateDashboardsNodeGroupRequest}

```json
{
  "updateMask": "string",
  "nodeGroupSpec": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "hostsCount": "string",
    "zoneIds": [
      "string"
    ],
    "subnetIds": [
      "string"
    ],
    "assignPublicIp": "boolean",
    "diskSizeAutoscaling": {
      "plannedUsageThreshold": "string",
      "emergencyUsageThreshold": "string",
      "diskSizeLimit": "string"
    }
  }
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| nodeGroupSpec | **[DashboardsNodeGroupUpdateSpec](#yandex.cloud.mdb.opensearch.v1.DashboardsNodeGroupUpdateSpec)**

New configuration for the host group. ||
|#

## DashboardsNodeGroupUpdateSpec {#yandex.cloud.mdb.opensearch.v1.DashboardsNodeGroupUpdateSpec}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hostsCount | **string** (int64)

Number of hosts in the group. ||
|| zoneIds[] | **string**

IDs of the availability zones for hosts ||
|| subnetIds[] | **string**

IDs of the subnets for hosts ||
|| assignPublicIp | **boolean**

Whether the hosts should get a public IP address. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Resources {#yandex.cloud.mdb.opensearch.v1.Resources}

A list of computational resources allocated to a host.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host. ||
|| diskSize | **string** (int64)

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "name": "string"
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateNodeGroupMetadata](#yandex.cloud.mdb.opensearch.v1.UpdateNodeGroupMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateNodeGroupMetadata {#yandex.cloud.mdb.opensearch.v1.UpdateNodeGroupMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the OpenSearch cluster where the host group is being updated. ||
|| name | **string**

Name of the host group being updated. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#