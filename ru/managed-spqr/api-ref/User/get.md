---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/users/{userName}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the SPQR cluster the user belongs to.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request.
          type: string
        userName:
          description: |-
            **string**
            Required field. Name of the SPQR User resource to return.
            To get the name of the user, use a [UserService.List](/docs/managed-spqr/api-ref/User/list#List) request.
          pattern: '[a-zA-Z0-9_]*'
          type: string
      required:
        - clusterId
        - userName
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Managed Service for SPQR API, REST: User.Get

Returns the specified SPQR User resource.

To get the list of available SPQR User resources, make a [List](/docs/managed-spqr/api-ref/User/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/users/{userName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the SPQR cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request. ||
|| userName | **string**

Required field. Name of the SPQR User resource to return.
To get the name of the user, use a [UserService.List](/docs/managed-spqr/api-ref/User/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.spqr.v1.User}

**HTTP Code: 200 - OK**

```json
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
```

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