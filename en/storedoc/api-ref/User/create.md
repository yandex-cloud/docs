---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/users
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the MongoDB cluster to create a user in.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
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
            **[UserSpec](#yandex.cloud.mdb.mongodb.v1.UserSpec)**
            Properties of the user to be created.
          $ref: '#/definitions/UserSpec'
      additionalProperties: false
    definitions:
      Permission:
        type: object
        properties:
          databaseName:
            description: |-
              **string**
              Name of the database that the permission grants access to.
            type: string
          roles:
            description: |-
              **string**
              MongoDB roles for the [databaseName](#yandex.cloud.mdb.mongodb.v1.Permission) database that the permission grants.
            type: array
            items:
              type: string
      UserSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the MongoDB user.
              The maximum string length in characters is 63. Value must match the regular expression ` ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$ `.
            pattern: ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$
            type: string
          password:
            description: |-
              **string**
              Password of the MongoDB user.
              The maximum string length in characters is 128.
            type: string
          permissions:
            description: |-
              **[Permission](#yandex.cloud.mdb.mongodb.v1.Permission)**
              Set of permissions to grant to the user.
            type: array
            items:
              $ref: '#/definitions/Permission'
          authType:
            description: |-
              **enum** (AuthType)
              Authentication type for the user. Defaults to AUTH_TYPE_PASSWORD.
              - `AUTH_TYPE_PASSWORD`: Password-based authentication (SCRAM).
              - `AUTH_TYPE_IAM`: IAM-based authentication via iam-auth-proxy (SASL/PLAIN, $external).
            type: string
            enum:
              - AUTH_TYPE_UNSPECIFIED
              - AUTH_TYPE_PASSWORD
              - AUTH_TYPE_IAM
          deletionProtection:
            description: |-
              **boolean**
              Deletion Protection inhibits deletion of the user
            type: boolean
        required:
          - name
---

# Managed Service for MongoDB API, REST: User.Create

Creates a MongoDB user in the specified cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster to create a user in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.mongodb.v1.CreateUserRequest}

```json
{
  "userSpec": {
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "databaseName": "string",
        "roles": [
          "string"
        ]
      }
    ],
    "authType": "string",
    "deletionProtection": "boolean"
  }
}
```

#|
||Field | Description ||
|| userSpec | **[UserSpec](#yandex.cloud.mdb.mongodb.v1.UserSpec)**

Properties of the user to be created. ||
|#

## UserSpec {#yandex.cloud.mdb.mongodb.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the MongoDB user.

The maximum string length in characters is 63. Value must match the regular expression ` ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$ `. ||
|| password | **string**

Password of the MongoDB user.

The maximum string length in characters is 128. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mongodb.v1.Permission)**

Set of permissions to grant to the user. ||
|| authType | **enum** (AuthType)

Authentication type for the user. Defaults to AUTH_TYPE_PASSWORD.

- `AUTH_TYPE_PASSWORD`: Password-based authentication (SCRAM).
- `AUTH_TYPE_IAM`: IAM-based authentication via iam-auth-proxy (SASL/PLAIN, $external). ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the user ||
|#

## Permission {#yandex.cloud.mdb.mongodb.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **string**

MongoDB roles for the `databaseName` database that the permission grants. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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