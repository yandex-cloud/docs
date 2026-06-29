# Managed Service for PostgreSQL API, REST: ManagedRepack.LaunchRepack

Launches new Repack in given cluster
(-- api-linter: yc::1702::method-verb-prefix=disabled --)

## HTTP request

```
POST https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}:managedRepack_launch
```

## Path parameters

Request to launch a new Repack in a cluster.

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the PostgreSQL cluster that Repack is running in.
To get the cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.postgresql.v1.LaunchRepackRequest}

```json
{
  "spec": {
    "type": "string",
    "dbname": "string",
    "targets": [
      {
        "schema": "string",
        // Includes only one of the fields `name`, `allInSchema`
        "name": "string",
        "allInSchema": "boolean"
        // end of the list of possible fields
      }
    ],
    "waitTimeout": "string",
    "jobs": "string"
  },
  "startTimeout": "string",
  "launchId": "string"
}
```

Request to launch a new Repack in a cluster.

#|
||Field | Description ||
|| spec | **[RepackSpec](#yandex.cloud.mdb.postgresql.v1.RepackSpec)**

Required field. Specification of repack to launch ||
|| startTimeout | **string** (duration)

Initial timeout to tell finished immediately from running repacks
Defaults to 1 second, if not specified ||
|| launchId | **string**

UUID of launch to be set by client ||
|#

## RepackSpec {#yandex.cloud.mdb.postgresql.v1.RepackSpec}

Represents specification for launching new Repack process

#|
||Field | Description ||
|| type | **enum** (RepackType)

Which objects to repack

- `REPACK_TYPE_INDEX`: Repack indexes.
- `REPACK_TYPE_TABLE`: Repack tables. ||
|| dbname | **string**

database name this repack process is working with ||
|| targets[] | **[RepackTarget](#yandex.cloud.mdb.postgresql.v1.RepackTarget)**

list of target objects this repack process is working with ||
|| waitTimeout | **string** (int64)

pg_repack option; timeout to cancel other backends on conflict ||
|| jobs | **string** (int64)

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

Includes only one of the fields `name`, `allInSchema`.

Object to repack within the schema. ||
|| allInSchema | **boolean**

All objects within given schema are to be repacked

Includes only one of the fields `name`, `allInSchema`.

Object to repack within the schema. ||
|#

## Response {#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse}

**HTTP Code: 200 - OK**

```json
{
  // Includes only one of the fields `finished`, `running`
  "finished": {
    "clusterId": "string",
    "exitCode": "string",
    "launchId": "string"
  },
  "running": {
    "clusterId": "string",
    "startTime": "string",
    "spec": {
      "type": "string",
      "dbname": "string",
      "targets": [
        {
          "schema": "string",
          // Includes only one of the fields `name`, `allInSchema`
          "name": "string",
          "allInSchema": "boolean"
          // end of the list of possible fields
        }
      ],
      "waitTimeout": "string",
      "jobs": "string"
    },
    "launchId": "string"
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
|| clusterId | **string**

Which cluster this repack was launched in ||
|| exitCode | **string** (int64)

Exit code of this repack launch ||
|| launchId | **string**

UUID of launch, identifier of specific instance of launched repack ||
|#

## RunningRepack {#yandex.cloud.mdb.postgresql.v1.RunningRepack}

Represents currently running repack process

#|
||Field | Description ||
|| clusterId | **string**

Which cluster this repack runs in ||
|| startTime | **string** (date-time)

When this repack process has been started

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| spec | **[RepackSpec](#yandex.cloud.mdb.postgresql.v1.RepackSpec2)**

Specification for this running repack ||
|| launchId | **string**

UUID of launch, identifier of specific instance of launched repack ||
|#

## RepackSpec {#yandex.cloud.mdb.postgresql.v1.RepackSpec2}

Represents specification for launching new Repack process

#|
||Field | Description ||
|| type | **enum** (RepackType)

Which objects to repack

- `REPACK_TYPE_INDEX`: Repack indexes.
- `REPACK_TYPE_TABLE`: Repack tables. ||
|| dbname | **string**

database name this repack process is working with ||
|| targets[] | **[RepackTarget](#yandex.cloud.mdb.postgresql.v1.RepackTarget2)**

list of target objects this repack process is working with ||
|| waitTimeout | **string** (int64)

pg_repack option; timeout to cancel other backends on conflict ||
|| jobs | **string** (int64)

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

Includes only one of the fields `name`, `allInSchema`.

Object to repack within the schema. ||
|| allInSchema | **boolean**

All objects within given schema are to be repacked

Includes only one of the fields `name`, `allInSchema`.

Object to repack within the schema. ||
|#