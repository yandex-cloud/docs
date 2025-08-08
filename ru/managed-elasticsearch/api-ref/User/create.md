---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/users
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Elasticsearch cluster to create a user in.
            To get the cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/Cluster/list#List) request.
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
            **[UserSpec](/docs/managed-elasticsearch/api-ref/Cluster/create#yandex.cloud.mdb.elasticsearch.v1.UserSpec)**
            Required field. Configuration of the user to create.
          $ref: '#/definitions/UserSpec'
      required:
        - userSpec
      additionalProperties: false
    definitions:
      UserSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the Elasticsearch user.
            pattern: '[a-zA-Z0-9_]*'
            type: string
          password:
            description: |-
              **string**
              Required field. Password of the Elasticsearch user.
            type: string
        required:
          - name
          - password
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/User/create.md
---

# Managed Service for Elasticsearch API, REST: User.Create

Creates a user in the specified cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Elasticsearch cluster to create a user in.

To get the cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.elasticsearch.v1.CreateUserRequest}

```json
{
  "userSpec": {
    "name": "string",
    "password": "string"
  }
}
```

#|
||Field | Description ||
|| userSpec | **[UserSpec](#yandex.cloud.mdb.elasticsearch.v1.UserSpec)**

Required field. Configuration of the user to create. ||
|#

## UserSpec {#yandex.cloud.mdb.elasticsearch.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the Elasticsearch user. ||
|| password | **string**

Required field. Password of the Elasticsearch user. ||
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
    "clusterId": "string"
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
|| metadata | **[CreateUserMetadata](#yandex.cloud.mdb.elasticsearch.v1.CreateUserMetadata)**

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
|| response | **[User](#yandex.cloud.mdb.elasticsearch.v1.User)**

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

## CreateUserMetadata {#yandex.cloud.mdb.elasticsearch.v1.CreateUserMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Elasticsearch cluster the user is being created in. ||
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

## User {#yandex.cloud.mdb.elasticsearch.v1.User}

An Elasticsearch user.

#|
||Field | Description ||
|| name | **string**

Name of the Elasticsearch user. ||
|| clusterId | **string**

ID of the Elasticsearch cluster the user belongs to. ||
|#