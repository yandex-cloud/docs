# Managed Service for PostgreSQL API, gRPC: ManagedRepackService.LaunchRepack

Launches new Repack in given cluster
(-- api-linter: yc::1702::method-verb-prefix=disabled --)

## gRPC request

**rpc LaunchRepack ([LaunchRepackRequest](#yandex.cloud.mdb.postgresql.v1.LaunchRepackRequest)) returns ([LaunchRepackResponse](#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse))**

## LaunchRepackRequest {#yandex.cloud.mdb.postgresql.v1.LaunchRepackRequest}

```json
{
  "cluster_id": "string",
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
  "start_timeout": "google.protobuf.Duration",
  "launch_id": "string"
}
```

Request to launch a new Repack in a cluster.

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the PostgreSQL cluster that Repack is running in.
To get the cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| spec | **[RepackSpec](#yandex.cloud.mdb.postgresql.v1.RepackSpec)**

Required field. Specification of repack to launch ||
|| start_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Initial timeout to tell finished immediately from running repacks
Defaults to 1 second, if not specified ||
|| launch_id | **string**

UUID of launch to be set by client ||
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

## LaunchRepackResponse {#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse}

```json
{
  // Includes only one of the fields `finished`, `running`
  "finished": {
    "cluster_id": "string",
    "exit_code": "int64",
    "launch_id": "string"
  },
  "running": {
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
  // end of the list of possible fields
}
```

Result of a Repack launch.

#|
||Field | Description ||
|| finished | **[FinishedRepack](#yandex.cloud.mdb.postgresql.v1.FinishedRepack)**

Returned if pg_repack finishes immediately before start_timeout expires

Includes only one of the fields `finished`, `running`.

Outcome of the launch: finished immediately or still running. ||
|| running | **[RunningRepack](#yandex.cloud.mdb.postgresql.v1.RunningRepack)**

Returned if pg_repack still runs after start_timeout expires

Includes only one of the fields `finished`, `running`.

Outcome of the launch: finished immediately or still running. ||
|#

## FinishedRepack {#yandex.cloud.mdb.postgresql.v1.FinishedRepack}

Represents already finished repack process

#|
||Field | Description ||
|| cluster_id | **string**

Which cluster this repack was launched in ||
|| exit_code | **int64**

Exit code of this repack launch ||
|| launch_id | **string**

UUID of launch, identifier of specific instance of launched repack ||
|#

## RunningRepack {#yandex.cloud.mdb.postgresql.v1.RunningRepack}

Represents currently running repack process

#|
||Field | Description ||
|| cluster_id | **string**

Which cluster this repack runs in ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

When this repack process has been started ||
|| spec | **[RepackSpec](#yandex.cloud.mdb.postgresql.v1.RepackSpec2)**

Specification for this running repack ||
|| launch_id | **string**

UUID of launch, identifier of specific instance of launched repack ||
|#

## RepackSpec {#yandex.cloud.mdb.postgresql.v1.RepackSpec2}

Represents specification for launching new Repack process

#|
||Field | Description ||
|| type | enum **RepackType**

Which objects to repack

- `REPACK_TYPE_INDEX`: Repack indexes.
- `REPACK_TYPE_TABLE`: Repack tables. ||
|| dbname | **string**

database name this repack process is working with ||
|| targets[] | **[RepackTarget](#yandex.cloud.mdb.postgresql.v1.RepackTarget2)**

list of target objects this repack process is working with ||
|| wait_timeout | **int64**

pg_repack option; timeout to cancel other backends on conflict ||
|| jobs | **int64**

pg_repack option; Use this many parallel jobs for each table ||
|#

## RepackTarget {#yandex.cloud.mdb.postgresql.v1.RepackTarget2}

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