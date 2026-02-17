---
editable: false
---

# Managed Service for SPQR API, gRPC: DatabaseService.Get

Returns the specified SPQR Database resource.

To get the list of available SPQR Database resources, make a [List](/docs/managed-spqr/api-ref/grpc/Database/list#List) request.

## gRPC request

**rpc Get ([GetDatabaseRequest](#yandex.cloud.mdb.spqr.v1.GetDatabaseRequest)) returns ([Database](#yandex.cloud.mdb.spqr.v1.Database))**

## GetDatabaseRequest {#yandex.cloud.mdb.spqr.v1.GetDatabaseRequest}

```json
{
  "cluster_id": "string",
  "database_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the SPQR cluster that the database belongs to.
To get the cluster ID use a [ClusterService.List](/docs/managed-spqr/api-ref/grpc/Cluster/list#List) request. ||
|| database_name | **string**

Required field. Name of the SPQR database to return.
To get the name of the database use a [DatabaseService.List](/docs/managed-spqr/api-ref/grpc/Database/list#List) request. ||
|#

## Database {#yandex.cloud.mdb.spqr.v1.Database}

```json
{
  "name": "string",
  "cluster_id": "string"
}
```

A SPQR Database resource. For more information, see the
[Developer's Guide](/docs/managed-spqr/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| cluster_id | **string**

ID of the SPQR cluster that the database belongs to. ||
|#