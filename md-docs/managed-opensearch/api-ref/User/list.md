[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for OpenSearch](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [User](index.md) > List

# Managed Service for OpenSearch API, REST: User.List

Returns the list of users for the specified OpenSearch cluster.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-opensearch/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the OpenSearch cluster.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.mdb.opensearch.v1.ListUsersRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. Set it to the `next_page_token` returned by a previous request.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.mdb.opensearch.v1.ListUsersResponse}

**HTTP Code: 200 - OK**

```json
{
  "users": [
    {
      "name": "string",
      "connectionManager": {
        "connectionId": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.opensearch.v1.User)**

Requested list of OpenSearch users. ||
|| nextPageToken | **string**

Token for getting the next page of results. ||
|#

## User {#yandex.cloud.mdb.opensearch.v1.User}

An OpenSearch user.

#|
||Field | Description ||
|| name | **string**

Name of the user. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.mdb.opensearch.v1.ConnectionManager)**

Connection Manager connection associated with the user. Read only field. ||
|#

## ConnectionManager {#yandex.cloud.mdb.opensearch.v1.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

ID of the Connection Manager connection. ||
|#