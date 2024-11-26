---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/User/get.md
---

# Managed Service for Elasticsearch API, gRPC: UserService.Get

Returns the specified Elasticsearch user.

To get the list of available Elasticsearch users, make a [List](/docs/managed-elasticsearch/api-ref/grpc/User/list#List) request.

## gRPC request

**rpc Get ([GetUserRequest](#yandex.cloud.mdb.elasticsearch.v1.GetUserRequest)) returns ([User](#yandex.cloud.mdb.elasticsearch.v1.User))**

## GetUserRequest {#yandex.cloud.mdb.elasticsearch.v1.GetUserRequest}

```json
{
  "cluster_id": "string",
  "user_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Elasticsearch cluster the user belongs to.

To get the cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/grpc/Cluster/list#List) request. ||
|| user_name | **string**

Required field. Name of the Elasticsearch user to return.

To get the name of the user, make a [UserService.List](/docs/managed-elasticsearch/api-ref/grpc/User/list#List) request. ||
|#

## User {#yandex.cloud.mdb.elasticsearch.v1.User}

```json
{
  "name": "string",
  "cluster_id": "string"
}
```

An Elasticsearch user.

#|
||Field | Description ||
|| name | **string**

Name of the Elasticsearch user. ||
|| cluster_id | **string**

ID of the Elasticsearch cluster the user belongs to. ||
|#