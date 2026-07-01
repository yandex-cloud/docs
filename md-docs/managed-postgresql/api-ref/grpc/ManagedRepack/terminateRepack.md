# Managed Service for PostgreSQL API, gRPC: ManagedRepackService.TerminateRepack

Terminates currently running Repack in given cluster


## gRPC request

**rpc TerminateRepack ([TerminateRepackRequest](#yandex.cloud.mdb.postgresql.v1.TerminateRepackRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

## TerminateRepackRequest {#yandex.cloud.mdb.postgresql.v1.TerminateRepackRequest}

```json
{
  "cluster_id": "string",
  "launch_id": "string"
}
```

Request to terminate a running Repack in a cluster.

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the PostgreSQL cluster that Repack is running in.
To get the cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| launch_id | **string**

Launch ID of Repack process to terminate.
Use launch_id specified when launching Repack, or
use [ManagedRepackService.ListRunningRepacks](listRunningRepacks.md#ListRunningRepacks) request to list currently running Repacks. ||
|#

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#