# Managed Service for MongoDB API, REST: Database.Get

Returns the specified MongoDB Database resource.
To get the list of available MongoDB Database resources, make a [List](../../../managed-mongodb/api-ref/Database/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/databases/{databaseName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster that the database belongs to.
To get the cluster ID use a [ClusterService.List](../../../managed-mongodb/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| databaseName | **string**

Required field. Name of the MongoDB database to return.
To get the name of the database use a [DatabaseService.List](../../../managed-mongodb/api-ref/Database/list#List) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Response {#yandex.cloud.mdb.mongodb.v1.Database}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string"
}
```

A MongoDB Database resource. For more information, see the
[Developer's Guide](../../../managed-mongodb/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the MongoDB cluster that the database belongs to. ||
|#