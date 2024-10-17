---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/User/get.md
---

# Managed Service for Elasticsearch API, REST: User.Get {#Get}

Returns the specified Elasticsearch user.

To get the list of available Elasticsearch users, make a [List](/docs/managed-elasticsearch/api-ref/User/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/users/{userName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Elasticsearch cluster the user belongs to.

To get the cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/Cluster/list#List) request. ||
|| userName | **string**

Required field. Name of the Elasticsearch user to return.

To get the name of the user, make a [UserService.List](/docs/managed-elasticsearch/api-ref/User/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.elasticsearch.v1.User}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string"
}
```

An Elasticsearch user.

#|
||Field | Description ||
|| name | **string**

Name of the Elasticsearch user. ||
|| clusterId | **string**

ID of the Elasticsearch cluster the user belongs to. ||
|#