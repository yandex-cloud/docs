---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/v1/api-ref/Cluster/updateHosts.md
---

# Managed Service for MongoDB API, REST: Cluster.UpdateHosts

Updates the specified parameters for the host.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/hosts:batchUpdate
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster to update hosts from.
To get the MongoDB cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.mongodb.v1.UpdateClusterHostsRequest}

```json
{
  "updateHostSpecs": [
    {
      "hostName": "string",
      "hidden": "boolean",
      "secondaryDelaySecs": "string",
      "priority": "number",
      "assignPublicIp": "boolean",
      "updateMask": "object",
      "tags": "object"
    }
  ]
}
```

#|
||Field | Description ||
|| updateHostSpecs[] | **[UpdateHostSpec](#yandex.cloud.mdb.mongodb.v1.UpdateHostSpec)**

New configurations to apply to hosts of a Managed Service for MongoDB cluster. ||
|#

## UpdateHostSpec {#yandex.cloud.mdb.mongodb.v1.UpdateHostSpec}

#|
||Field | Description ||
|| hostName | **string**

Required field. Host to be updated. Specify the [host FQDN](https://yandex.cloud/en/docs/managed-mongodb/operations/connect/#fqdn). ||
|| hidden | **boolean**

Determines if the host is a hidden replica set member.

Such members cannot become primary in a replica set, and they are invisible to client applications. However, hidden members can participate in elections of the primary host. For more information, see the [MongoDB documentation](https://www.mongodb.com/docs/manual/core/replica-set-hidden-member/). ||
|| secondaryDelaySecs | **string** (int64)

The time, in seconds, by which the given replica set member lags behind the primary host. ||
|| priority | **number** (double)

Priority of the host to be elected as the primary in the replica set.

The minimum value is `0` if the Managed Service for MongoDB cluster contains three or more secondary hosts. Otherwise, the minimum value is `1`. ||
|| assignPublicIp | **boolean**

Determines whether the host should get a public IP address after the update. ||
|| updateMask | **object** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| tags | **object** (map<**string**, **string**>)

Host tag list that contains key-value pairs for the given replica set member. For more information about how to specify the tags and what values to choose, see the [MongoDB documentation](https://www.mongodb.com/docs/manual/reference/replica-configuration/#mongodb-rsconf-rsconf.members-n-.tags). ||
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
    "hostNames": [
      "string"
    ]
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
|| metadata | **[UpdateClusterHostsMetadata](#yandex.cloud.mdb.mongodb.v1.UpdateClusterHostsMetadata)**

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

## UpdateClusterHostsMetadata {#yandex.cloud.mdb.mongodb.v1.UpdateClusterHostsMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the MongoDB cluster to update host from. ||
|| hostNames[] | **string**

Name of host that are being updated. ||
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