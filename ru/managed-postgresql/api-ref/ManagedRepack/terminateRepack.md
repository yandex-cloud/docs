---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}:managedRepack_terminate
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. Required. ID of the PostgreSQL cluster that Repack is running in.
            To get the cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        launchId:
          description: |-
            **string**
            Launch ID of Repack process to terminate.
            Use launch_id specified when launching Repack, or
            use [ManagedRepackService.ListRunningRepacks](/docs/managed-postgresql/api-ref/ManagedRepack/listRunningRepacks#ListRunningRepacks) request to list currently running Repacks.
          type: string
      additionalProperties: false
    definitions: null
---

# Managed Service for PostgreSQL API, REST: ManagedRepack.TerminateRepack

Terminates currently running Repack in given cluster
(-- api-linter: yc::1702::method-verb-prefix=disabled --)

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}:managedRepack_terminate
```

## Path parameters

Request to terminate a running Repack in a cluster.

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the PostgreSQL cluster that Repack is running in.
To get the cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.

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
use [ManagedRepackService.ListRunningRepacks](/docs/managed-postgresql/api-ref/ManagedRepack/listRunningRepacks#ListRunningRepacks) request to list currently running Repacks. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**