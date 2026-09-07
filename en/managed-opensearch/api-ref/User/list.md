---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/users
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. Required. ID of the OpenSearch cluster.
            The maximum string length in characters is 50.
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
            The maximum number of results per page to return.
            Acceptable values are 0 to 1000, inclusive.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set it to the `next_page_token` returned by a previous request.
            The maximum string length in characters is 100.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Managed Service for OpenSearch API, REST: User.List

Returns the list of users for the specified OpenSearch cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/users
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