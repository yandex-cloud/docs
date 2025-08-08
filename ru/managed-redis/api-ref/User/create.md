---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}/users
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Redis cluster to create a user in.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-redis/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        userSpec:
          description: |-
            **[UserSpec](/docs/managed-redis/api-ref/Cluster/create#yandex.cloud.mdb.redis.v1.UserSpec)**
            Properties of the user to be created.
          $ref: '#/definitions/UserSpec'
      additionalProperties: false
    definitions:
      Permissions:
        type: object
        properties:
          patterns:
            description: |-
              **string**
              Keys patterns user has permission to.
            type: string
          pubSubChannels:
            description: |-
              **string**
              Channel patterns user has permissions to.
            type: string
          categories:
            description: |-
              **string**
              Command categories user has permissions to.
            type: string
          commands:
            description: |-
              **string**
              Commands user can execute.
            type: string
          sanitizePayload:
            description: |-
              **string**
              SanitizePayload parameter.
            type: string
      UserSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the Redis user.
            pattern: ^[a-zA-Z0-9_][a-zA-Z0-9_-]*$
            type: string
          passwords:
            description: |-
              **string**
              Password of the Redis user.
            uniqueItems: true
            pattern: ^[a-zA-Z0-9@=+?*.,!&#$^<>_-]*$
            type: array
            items:
              type: string
          permissions:
            description: |-
              **[Permissions](/docs/managed-redis/api-ref/Cluster/create#yandex.cloud.mdb.redis.v1.Permissions)**
              Set of permissions to grant to the user.
            $ref: '#/definitions/Permissions'
          enabled:
            description: |-
              **boolean**
              Is Redis user enabled
            type: boolean
        required:
          - name
sourcePath: en/_api-ref/mdb/redis/v1/api-ref/User/create.md
---

# Managed Service for Redis API, REST: User.Create

Creates a Redis user in the specified cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Redis cluster to create a user in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-redis/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.redis.v1.CreateUserRequest}

```json
{
  "userSpec": {
    "name": "string",
    "passwords": [
      "string"
    ],
    "permissions": {
      "patterns": "string",
      "pubSubChannels": "string",
      "categories": "string",
      "commands": "string",
      "sanitizePayload": "string"
    },
    "enabled": "boolean"
  }
}
```

#|
||Field | Description ||
|| userSpec | **[UserSpec](#yandex.cloud.mdb.redis.v1.UserSpec)**

Properties of the user to be created. ||
|#

## UserSpec {#yandex.cloud.mdb.redis.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the Redis user. ||
|| passwords[] | **string**

Password of the Redis user. ||
|| permissions | **[Permissions](#yandex.cloud.mdb.redis.v1.Permissions)**

Set of permissions to grant to the user. ||
|| enabled | **boolean**

Is Redis user enabled ||
|#

## Permissions {#yandex.cloud.mdb.redis.v1.Permissions}

#|
||Field | Description ||
|| patterns | **string**

Keys patterns user has permission to. ||
|| pubSubChannels | **string**

Channel patterns user has permissions to. ||
|| categories | **string**

Command categories user has permissions to. ||
|| commands | **string**

Commands user can execute. ||
|| sanitizePayload | **string**

SanitizePayload parameter. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "userName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "name": "string",
    "clusterId": "string",
    "permissions": {
      "patterns": "string",
      "pubSubChannels": "string",
      "categories": "string",
      "commands": "string",
      "sanitizePayload": "string"
    },
    "enabled": "boolean",
    "aclOptions": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateUserMetadata](#yandex.cloud.mdb.redis.v1.CreateUserMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[User](#yandex.cloud.mdb.redis.v1.User)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateUserMetadata {#yandex.cloud.mdb.redis.v1.CreateUserMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Redis cluster the user is being created in. ||
|| userName | **string**

Name of the user that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## User {#yandex.cloud.mdb.redis.v1.User}

A Redis User resource. For more information, see the
[Developer's Guide](/docs/managed-redis/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the Redis user. ||
|| clusterId | **string**

ID of the Redis cluster the user belongs to. ||
|| permissions | **[Permissions](#yandex.cloud.mdb.redis.v1.Permissions2)**

Set of permissions to grant to the user. ||
|| enabled | **boolean**

Is redis user enabled ||
|| aclOptions | **string**

Raw ACL string inside of Redis ||
|#

## Permissions {#yandex.cloud.mdb.redis.v1.Permissions2}

#|
||Field | Description ||
|| patterns | **string**

Keys patterns user has permission to. ||
|| pubSubChannels | **string**

Channel patterns user has permissions to. ||
|| categories | **string**

Command categories user has permissions to. ||
|| commands | **string**

Commands user can execute. ||
|| sanitizePayload | **string**

SanitizePayload parameter. ||
|#