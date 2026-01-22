---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/shards/{shardName}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the MongoDB cluster that the shard belongs to.
            To get the cluster ID use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
        shardName:
          description: |-
            **string**
            Required field. Name of the MongoDB shard to return.
            To get the name of the shard use a [ClusterService.ListShards](/docs/managed-mongodb/api-ref/Cluster/listShards#ListShards) request.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
      required:
        - clusterId
        - shardName
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/mongodb/v1/api-ref/Cluster/getShard.md
---

# Managed Service for MongoDB API, REST: Cluster.GetShard

Returns the specified shard.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/shards/{shardName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster that the shard belongs to.
To get the cluster ID use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| shardName | **string**

Required field. Name of the MongoDB shard to return.
To get the name of the shard use a [ClusterService.ListShards](/docs/managed-mongodb/api-ref/Cluster/listShards#ListShards) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Response {#yandex.cloud.mdb.mongodb.v1.Shard}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the shard. ||
|| clusterId | **string**

ID of the cluster that the shard belongs to. ||
|#