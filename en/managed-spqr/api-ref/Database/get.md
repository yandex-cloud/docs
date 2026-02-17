---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/databases/{databaseName}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the SPQR cluster that the database belongs to.
            To get the cluster ID use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request.
          type: string
        databaseName:
          description: |-
            **string**
            Required field. Name of the SPQR database to return.
            To get the name of the database use a [DatabaseService.List](/docs/managed-spqr/api-ref/Database/list#List) request.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
      required:
        - clusterId
        - databaseName
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Managed Service for SPQR API, REST: Database.Get

Returns the specified SPQR Database resource.

To get the list of available SPQR Database resources, make a [List](/docs/managed-spqr/api-ref/Database/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/databases/{databaseName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the SPQR cluster that the database belongs to.
To get the cluster ID use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request. ||
|| databaseName | **string**

Required field. Name of the SPQR database to return.
To get the name of the database use a [DatabaseService.List](/docs/managed-spqr/api-ref/Database/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.spqr.v1.Database}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string"
}
```

A SPQR Database resource. For more information, see the
[Developer's Guide](/docs/managed-spqr/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the SPQR cluster that the database belongs to. ||
|#