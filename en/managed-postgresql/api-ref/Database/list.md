---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/databases
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the PostgreSQL cluster to list databases in.
            To get the cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListDatabasesResponse.nextPageToken](/docs/managed-postgresql/api-ref/Database/list#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, Set `pageToken` to the [ListDatabasesResponse.nextPageToken](/docs/managed-postgresql/api-ref/Database/list#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse)
            returned by the previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/postgresql/v1/api-ref/Database/list.md
---

# Managed Service for PostgreSQL API, REST: Database.List

Retrieves the list of PostgreSQL Database resources in the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/databases
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster to list databases in.
To get the cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.postgresql.v1.ListDatabasesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListDatabasesResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, Set `pageToken` to the [ListDatabasesResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse)
returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse}

**HTTP Code: 200 - OK**

```json
{
  "databases": [
    {
      "name": "string",
      "clusterId": "string",
      "owner": "string",
      "lcCollate": "string",
      "lcCtype": "string",
      "extensions": [
        {
          "name": "string",
          "version": "string"
        }
      ],
      "templateDb": "string",
      "deletionProtection": "boolean"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| databases[] | **[Database](#yandex.cloud.mdb.postgresql.v1.Database)**

List of PostgreSQL Database resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDatabasesRequest.pageSize](#yandex.cloud.mdb.postgresql.v1.ListDatabasesRequest), use the `nextPageToken` as the value
for the [ListDatabasesRequest.pageToken](#yandex.cloud.mdb.postgresql.v1.ListDatabasesRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Database {#yandex.cloud.mdb.postgresql.v1.Database}

A PostgreSQL Database resource. For more information, see
the [Developer's Guide](/docs/managed-postgresql/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the PostgreSQL cluster that the database belongs to. ||
|| owner | **string**

Name of the user assigned as the owner of the database. ||
|| lcCollate | **string**

POSIX locale for string sorting order.
Can only be set at creation time. ||
|| lcCtype | **string**

POSIX locale for character classification.
Can only be set at creation time. ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.postgresql.v1.Extension)**

PostgreSQL extensions enabled for the database. ||
|| templateDb | **string**

Name of the database template. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the database

Default value: `unspecified` (inherits cluster's deletion_protection) ||
|#

## Extension {#yandex.cloud.mdb.postgresql.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Name of the extension, e.g. `pg_trgm` or `pg_btree`.
Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/extensions/cluster-extensions). ||
|| version | **string**

Version of the extension. The setting is deprecated and has no effect. ||
|#