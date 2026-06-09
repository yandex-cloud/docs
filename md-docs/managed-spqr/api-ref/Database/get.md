# Managed Service for SPQR API, REST: Database.Get

Returns the specified SPQR Database resource.
To get the list of available SPQR Database resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/databases/{databaseName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the SPQR cluster that the database belongs to.
To get the cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| databaseName | **string**

Required field. Name of the SPQR database to return.
To get the name of the database use a [DatabaseService.List](list.md#List) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Response {#yandex.cloud.mdb.spqr.v1.Database}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "deletionProtection": "boolean"
}
```

A SPQR Database resource. For more information, see the
[Developer's Guide](../../concepts/index.md).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the SPQR cluster that the database belongs to. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the database ||
|#