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
            Required field. ID of the MongoDB cluster the user belongs to.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
        userName:
          description: |-
            **string**
            Required field. Name of the MongoDB User resource to return.
            To get the name of the user, use a [UserService.List](/docs/managed-mongodb/api-ref/User/list#List) request.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
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

# Managed Service for MongoDB API, REST: User.Get

Returns the specified MongoDB User resource.

To get the list of available MongoDB User resources, make a [List](/docs/managed-mongodb/api-ref/User/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/users/{userName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster the user belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| userName | **string**

Required field. Name of the MongoDB User resource to return.
To get the name of the user, use a [UserService.List](/docs/managed-mongodb/api-ref/User/list#List) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `. ||
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
  ]
}
```

A MongoDB User resource. For more information, see the
[Developer's Guide](/docs/managed-mongodb/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the MongoDB user. ||
|| clusterId | **string**

ID of the MongoDB cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mongodb.v1.Permission)**

Set of permissions granted to the user. ||
|#

## Permission {#yandex.cloud.mdb.mongodb.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **string**

MongoDB roles for the `databaseName` database that the permission grants. ||
|#