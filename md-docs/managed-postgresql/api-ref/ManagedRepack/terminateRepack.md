[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for PostgreSQL](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [ManagedRepack](index.md) > TerminateRepack

# Managed Service for PostgreSQL API, REST: ManagedRepack.TerminateRepack

Terminates currently running Repack in given cluster


## HTTP request

```
POST https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}:managedRepack_terminate
```

## Path parameters

Request to terminate a running Repack in a cluster.

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the PostgreSQL cluster that Repack is running in.
To get the cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.postgresql.v1.TerminateRepackRequest}

```json
{
  "launchId": "string"
}
```

Request to terminate a running Repack in a cluster.

#|
||Field | Description ||
|| launchId | **string**

Launch ID of Repack process to terminate.
Use launch_id specified when launching Repack, or
use [ManagedRepackService.ListRunningRepacks](listRunningRepacks.md#ListRunningRepacks) request to list currently running Repacks. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**