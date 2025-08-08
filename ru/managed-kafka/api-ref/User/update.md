---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/users/{userName}
    method: patch
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Apache Kafka® cluster the user belongs to.
            To get the cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request.
          type: string
        userName:
          description: |-
            **string**
            Required field. Name of the user to be updated.
            To get the name of the user, make a [UserService.List](/docs/managed-kafka/api-ref/User/list#List) request.
          pattern: '[a-zA-Z0-9_]*'
          type: string
      required:
        - clusterId
        - userName
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        password:
          description: |-
            **string**
            New password for the user.
          type: string
        permissions:
          description: |-
            **[Permission](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.Permission)**
            New set of permissions for the user.
          type: array
          items:
            $ref: '#/definitions/Permission'
      additionalProperties: false
    definitions:
      Permission:
        type: object
        properties:
          topicName:
            description: |-
              **string**
              Name or prefix-pattern with wildcard for the topic that the permission grants access to.
              With roles SCHEMA_READER and SCHEMA_WRITER: string that contains set of schema registry subjects, separated by ';'.
              To get the topic name, make a [TopicService.List](/docs/managed-kafka/api-ref/Topic/list#List) request.
            type: string
          role:
            description: |-
              **enum** (AccessRole)
              Access role type to grant to the user.
              - `ACCESS_ROLE_UNSPECIFIED`
              - `ACCESS_ROLE_PRODUCER`: Producer role for the user.
              - `ACCESS_ROLE_CONSUMER`: Consumer role for the user.
              - `ACCESS_ROLE_ADMIN`: Admin role for the user.
              - `ACCESS_ROLE_TOPIC_ADMIN`: Admin permissions on topics role for the user.
              - `ACCESS_ROLE_TOPIC_PRODUCER`
              - `ACCESS_ROLE_TOPIC_CONSUMER`
              - `ACCESS_ROLE_SCHEMA_READER`
              - `ACCESS_ROLE_SCHEMA_WRITER`
            type: string
            enum:
              - ACCESS_ROLE_UNSPECIFIED
              - ACCESS_ROLE_PRODUCER
              - ACCESS_ROLE_CONSUMER
              - ACCESS_ROLE_ADMIN
              - ACCESS_ROLE_TOPIC_ADMIN
              - ACCESS_ROLE_TOPIC_PRODUCER
              - ACCESS_ROLE_TOPIC_CONSUMER
              - ACCESS_ROLE_SCHEMA_READER
              - ACCESS_ROLE_SCHEMA_WRITER
          allowHosts:
            description: |-
              **string**
              Lists hosts allowed for this permission.
              Only ip-addresses allowed as value of single host.
              When not defined, access from any host is allowed.
              Bare in mind that the same host might appear in multiple permissions at the same time,
              hence removing individual permission doesn't automatically restricts access from the [allowHosts](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.Permission) of the permission.
              If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed.
            type: array
            items:
              type: string
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/User/update.md
---

# Managed Service for Apache Kafka® API, REST: User.Update

Updates the specified Kafka user.

## HTTP request

```
PATCH https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/users/{userName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster the user belongs to.

To get the cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request. ||
|| userName | **string**

Required field. Name of the user to be updated.

To get the name of the user, make a [UserService.List](/docs/managed-kafka/api-ref/User/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.kafka.v1.UpdateUserRequest}

```json
{
  "updateMask": "string",
  "password": "string",
  "permissions": [
    {
      "topicName": "string",
      "role": "string",
      "allowHosts": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| password | **string**

New password for the user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.kafka.v1.Permission)**

New set of permissions for the user. ||
|#

## Permission {#yandex.cloud.mdb.kafka.v1.Permission}

#|
||Field | Description ||
|| topicName | **string**

Name or prefix-pattern with wildcard for the topic that the permission grants access to.
With roles SCHEMA_READER and SCHEMA_WRITER: string that contains set of schema registry subjects, separated by ';'.

To get the topic name, make a [TopicService.List](/docs/managed-kafka/api-ref/Topic/list#List) request. ||
|| role | **enum** (AccessRole)

Access role type to grant to the user.

- `ACCESS_ROLE_UNSPECIFIED`
- `ACCESS_ROLE_PRODUCER`: Producer role for the user.
- `ACCESS_ROLE_CONSUMER`: Consumer role for the user.
- `ACCESS_ROLE_ADMIN`: Admin role for the user.
- `ACCESS_ROLE_TOPIC_ADMIN`: Admin permissions on topics role for the user.
- `ACCESS_ROLE_TOPIC_PRODUCER`
- `ACCESS_ROLE_TOPIC_CONSUMER`
- `ACCESS_ROLE_SCHEMA_READER`
- `ACCESS_ROLE_SCHEMA_WRITER` ||
|| allowHosts[] | **string**

Lists hosts allowed for this permission.
Only ip-addresses allowed as value of single host.
When not defined, access from any host is allowed.

Bare in mind that the same host might appear in multiple permissions at the same time,
hence removing individual permission doesn't automatically restricts access from the `allowHosts` of the permission.
If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. ||
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
    "permissions": [
      {
        "topicName": "string",
        "role": "string",
        "allowHosts": [
          "string"
        ]
      }
    ]
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
|| metadata | **[UpdateUserMetadata](#yandex.cloud.mdb.kafka.v1.UpdateUserMetadata)**

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
|| response | **[User](#yandex.cloud.mdb.kafka.v1.User)**

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

## UpdateUserMetadata {#yandex.cloud.mdb.kafka.v1.UpdateUserMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Apache Kafka® cluster the user belongs to. ||
|| userName | **string**

Name of the user that is being updated. ||
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

## User {#yandex.cloud.mdb.kafka.v1.User}

A Kafka user.
For more information, see the [Operations -> Accounts](/docs/managed-kafka/operations/cluster-accounts) section of the documentation.

#|
||Field | Description ||
|| name | **string**

Name of the Kafka user. ||
|| clusterId | **string**

ID of the Apache Kafka® cluster the user belongs to.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.kafka.v1.Permission2)**

Set of permissions granted to this user. ||
|#

## Permission {#yandex.cloud.mdb.kafka.v1.Permission2}

#|
||Field | Description ||
|| topicName | **string**

Name or prefix-pattern with wildcard for the topic that the permission grants access to.
With roles SCHEMA_READER and SCHEMA_WRITER: string that contains set of schema registry subjects, separated by ';'.

To get the topic name, make a [TopicService.List](/docs/managed-kafka/api-ref/Topic/list#List) request. ||
|| role | **enum** (AccessRole)

Access role type to grant to the user.

- `ACCESS_ROLE_UNSPECIFIED`
- `ACCESS_ROLE_PRODUCER`: Producer role for the user.
- `ACCESS_ROLE_CONSUMER`: Consumer role for the user.
- `ACCESS_ROLE_ADMIN`: Admin role for the user.
- `ACCESS_ROLE_TOPIC_ADMIN`: Admin permissions on topics role for the user.
- `ACCESS_ROLE_TOPIC_PRODUCER`
- `ACCESS_ROLE_TOPIC_CONSUMER`
- `ACCESS_ROLE_SCHEMA_READER`
- `ACCESS_ROLE_SCHEMA_WRITER` ||
|| allowHosts[] | **string**

Lists hosts allowed for this permission.
Only ip-addresses allowed as value of single host.
When not defined, access from any host is allowed.

Bare in mind that the same host might appear in multiple permissions at the same time,
hence removing individual permission doesn't automatically restricts access from the `allowHosts` of the permission.
If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. ||
|#