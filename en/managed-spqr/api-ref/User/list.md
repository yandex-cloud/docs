---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/users
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the cluster to list SPQR users in.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request.
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
            results is larger than `pageSize`, the service returns a [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListUsersResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListUsersResponse) returned by the previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Managed Service for SPQR API, REST: User.List

Retrieves the list of SPQR User resources in the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to list SPQR users in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.spqr.v1.ListUsersRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListUsersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListUsersResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListUsersResponse) returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.spqr.v1.ListUsersResponse}

**HTTP Code: 200 - OK**

```json
{
  "users": [
    {
      "name": "string",
      "clusterId": "string",
      "permissions": [
        {
          "databaseName": "string"
        }
      ],
      "settings": {
        "connectionLimit": "string",
        "connectionRetries": "string"
      },
      "grants": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.spqr.v1.User)**

List of SPQR User resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListUsersRequest.pageSize](#yandex.cloud.mdb.spqr.v1.ListUsersRequest), use the `nextPageToken` as the value
for the [ListUsersRequest.pageToken](#yandex.cloud.mdb.spqr.v1.ListUsersRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## User {#yandex.cloud.mdb.spqr.v1.User}

A SPQR User resource. For more information, see the
[Developer's Guide](/docs/managed-spqr/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the SPQR user. ||
|| clusterId | **string**

ID of the SPQR cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.spqr.v1.Permission)**

Set of permissions granted to the user. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.spqr.v1.UserSettings)**

SPQR Settings for this user ||
|| grants[] | **string**

User grants ||
|#

## Permission {#yandex.cloud.mdb.spqr.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.spqr.v1.UserSettings}

#|
||Field | Description ||
|| connectionLimit | **string** (int64) ||
|| connectionRetries | **string** (int64) ||
|#