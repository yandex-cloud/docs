[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for PostgreSQL](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [ManagedRepack](index.md) > ListRunningRepacks

# Managed Service for PostgreSQL API, gRPC: ManagedRepackService.ListRunningRepacks

Lists currently running in given cluster Repacks


## gRPC request

**rpc ListRunningRepacks ([ListRunningRepacksRequest](#yandex.cloud.mdb.postgresql.v1.ListRunningRepacksRequest)) returns ([ListRunningRepacksResponse](#yandex.cloud.mdb.postgresql.v1.ListRunningRepacksResponse))**

## ListRunningRepacksRequest {#yandex.cloud.mdb.postgresql.v1.ListRunningRepacksRequest}

```json
{
  "cluster_id": "string"
}
```

Request to list currently running Repacks in a cluster.

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the PostgreSQL cluster that Repack is running in.
To get the cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|#

## ListRunningRepacksResponse {#yandex.cloud.mdb.postgresql.v1.ListRunningRepacksResponse}

```json
{
  "repacks": [
    {
      "cluster_id": "string",
      "start_time": "google.protobuf.Timestamp",
      "spec": {
        "type": "RepackType",
        "dbname": "string",
        "targets": [
          {
            "schema": "string",
            // Includes only one of the fields `name`, `all_in_schema`
            "name": "string",
            "all_in_schema": "bool"
            // end of the list of possible fields
          }
        ],
        "wait_timeout": "int64",
        "jobs": "int64"
      },
      "launch_id": "string"
    }
  ]
}
```

Response with the list of currently running Repacks.

#|
||Field | Description ||
|| repacks[] | **[RunningRepack](#yandex.cloud.mdb.postgresql.v1.RunningRepack)**

List of RunningRepack. ||
|#

## RunningRepack {#yandex.cloud.mdb.postgresql.v1.RunningRepack}

Represents currently running repack process

#|
||Field | Description ||
|| cluster_id | **string**

Which cluster this repack runs in ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

When this repack process has been started ||
|| spec | **[RepackSpec](#yandex.cloud.mdb.postgresql.v1.RepackSpec)**

Specification for this running repack ||
|| launch_id | **string**

UUID of launch, identifier of specific instance of launched repack ||
|#

## RepackSpec {#yandex.cloud.mdb.postgresql.v1.RepackSpec}

Represents specification for launching new Repack process

#|
||Field | Description ||
|| type | enum **RepackType**

Which objects to repack

- `REPACK_TYPE_INDEX`: Repack indexes.
- `REPACK_TYPE_TABLE`: Repack tables. ||
|| dbname | **string**

database name this repack process is working with ||
|| targets[] | **[RepackTarget](#yandex.cloud.mdb.postgresql.v1.RepackTarget)**

list of target objects this repack process is working with ||
|| wait_timeout | **int64**

pg_repack option; timeout to cancel other backends on conflict ||
|| jobs | **int64**

pg_repack option; Use this many parallel jobs for each table ||
|#

## RepackTarget {#yandex.cloud.mdb.postgresql.v1.RepackTarget}

Single object to repack

#|
||Field | Description ||
|| schema | **string**

Schema of object to be repacked
If not given, defaults to "public" ||
|| name | **string**

Name of object to be repacked

Includes only one of the fields `name`, `all_in_schema`.

Object to repack within the schema. ||
|| all_in_schema | **bool**

All objects within given schema are to be repacked

Includes only one of the fields `name`, `all_in_schema`.

Object to repack within the schema. ||
|#