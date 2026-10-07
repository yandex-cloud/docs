---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/users/{userName}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the StoreDoc cluster the user belongs to.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
        userName:
          description: |-
            **string**
            Required field. Name of the StoreDoc User resource to return.
            To get the name of the user, use a [UserService.List](/docs/managed-mongodb/api-ref/User/list#List) request.
            The maximum string length in characters is 63. Value must match the regular expression ` ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$ `.
          pattern: ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$
          type: string
      required:
        - clusterId
        - userName
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Managed Service for MongoDB API, REST: User.Get

Returns the specified StoreDoc User resource.
To get the list of available StoreDoc User resources, make a [List](/docs/managed-mongodb/api-ref/User/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/users/{userName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the StoreDoc cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| userName | **string**

Required field. Name of the StoreDoc User resource to return.
To get the name of the user, use a [UserService.List](/docs/managed-mongodb/api-ref/User/list#List) request.

The maximum string length in characters is 63. Value must match the regular expression ` ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$ `. ||
|#

## Response {#yandex.cloud.mdb.mongodb.v1.User}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string",
      "roles": [
        "string"
      ]
    }
  ],
  "connectionManager": {
    "connectionId": "string"
  },
  "authType": "string",
  "deletionProtection": "boolean"
}
```

A StoreDoc User resource. For more information, see the
[Developer's Guide](/docs/managed-mongodb/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the StoreDoc user. ||
|| clusterId | **string**

ID of the StoreDoc cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mongodb.v1.Permission)**

Set of permissions granted to the user. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.mdb.mongodb.v1.ConnectionManager)**

Connection Manager connection configuration. ||
|| authType | **enum** (AuthType)

Authentication type for the user.

- `AUTH_TYPE_PASSWORD`: Password-based authentication (SCRAM).
- `AUTH_TYPE_IAM`: IAM-based authentication via iam-auth-proxy (SASL/PLAIN, $external). ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the user. ||
|#

## Permission {#yandex.cloud.mdb.mongodb.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **string**

StoreDoc roles for the `databaseName` database that the permission grants. ||
|#

## ConnectionManager {#yandex.cloud.mdb.mongodb.v1.ConnectionManager}

Connection Manager connection configuration.

#|
||Field | Description ||
|| connectionId | **string**

ID of Connection Manager connection. ||
|#