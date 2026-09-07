---
editable: false
---

# Managed Service for OpenSearch API, gRPC: UserService.Get

Returns the specified OpenSearch user.

## gRPC request

**rpc Get ([GetUserRequest](#yandex.cloud.mdb.opensearch.v1.GetUserRequest)) returns ([User](#yandex.cloud.mdb.opensearch.v1.User))**

## GetUserRequest {#yandex.cloud.mdb.opensearch.v1.GetUserRequest}

```json
{
  "cluster_id": "string",
  "user_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the OpenSearch cluster.

The maximum string length in characters is 50. ||
|| user_name | **string**

Required field. Required. Name of the user to return.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `. ||
|#

## User {#yandex.cloud.mdb.opensearch.v1.User}

```json
{
  "name": "string",
  "connection_manager": {
    "connection_id": "string"
  }
}
```

An OpenSearch user.

#|
||Field | Description ||
|| name | **string**

Name of the user. ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.mdb.opensearch.v1.ConnectionManager)**

Connection Manager connection associated with the user. Read only field. ||
|#

## ConnectionManager {#yandex.cloud.mdb.opensearch.v1.ConnectionManager}

#|
||Field | Description ||
|| connection_id | **string**

ID of the Connection Manager connection. ||
|#