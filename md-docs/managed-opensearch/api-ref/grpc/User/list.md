[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for OpenSearch](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [User](index.md) > List

# Managed Service for OpenSearch API, gRPC: UserService.List

Returns the list of users for the specified OpenSearch cluster.

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.mdb.opensearch.v1.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.mdb.opensearch.v1.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.mdb.opensearch.v1.ListUsersRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the OpenSearch cluster.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. Set it to the `next_page_token` returned by a previous request.

The maximum string length in characters is 100. ||
|#

## ListUsersResponse {#yandex.cloud.mdb.opensearch.v1.ListUsersResponse}

```json
{
  "users": [
    {
      "name": "string",
      "connection_manager": {
        "connection_id": "string"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.opensearch.v1.User)**

Requested list of OpenSearch users. ||
|| next_page_token | **string**

Token for getting the next page of results. ||
|#

## User {#yandex.cloud.mdb.opensearch.v1.User}

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