---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/User/update.md
---

# Managed Service for Apache Kafka® API, gRPC: UserService.Update

Updates the specified Kafka user.

## gRPC request

**rpc Update ([UpdateUserRequest](#yandex.cloud.mdb.kafka.v1.UpdateUserRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateUserRequest {#yandex.cloud.mdb.kafka.v1.UpdateUserRequest}

```json
{
  "cluster_id": "string",
  "user_name": "string",
  "update_mask": "google.protobuf.FieldMask",
  "password": "string",
  "permissions": [
    {
      "topic_name": "string",
      "role": "AccessRole",
      "allow_hosts": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Apache Kafka® cluster the user belongs to.

To get the cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| user_name | **string**

Required field. Name of the user to be updated.

To get the name of the user, make a [UserService.List](/docs/managed-kafka/api-ref/grpc/User/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)** ||
|| password | **string**

New password for the user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.kafka.v1.Permission)**

New set of permissions for the user. ||
|#

## Permission {#yandex.cloud.mdb.kafka.v1.Permission}

#|
||Field | Description ||
|| topic_name | **string**

Name or prefix-pattern with wildcard for the topic that the permission grants access to.

To get the topic name, make a [TopicService.List](/docs/managed-kafka/api-ref/grpc/Topic/list#List) request. ||
|| role | enum **AccessRole**

Access role type to grant to the user.

- `ACCESS_ROLE_UNSPECIFIED`
- `ACCESS_ROLE_PRODUCER`: Producer role for the user.
- `ACCESS_ROLE_CONSUMER`: Consumer role for the user.
- `ACCESS_ROLE_ADMIN`: Admin role for the user. ||
|| allow_hosts[] | **string**

Lists hosts allowed for this permission.
Only ip-addresses allowed as value of single host.
When not defined, access from any host is allowed.

Bare in mind that the same host might appear in multiple permissions at the same time,
hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission.
If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "user_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "cluster_id": "string",
    "permissions": [
      {
        "topic_name": "string",
        "role": "AccessRole",
        "allow_hosts": [
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateUserMetadata](#yandex.cloud.mdb.kafka.v1.UpdateUserMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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
|| cluster_id | **string**

ID of the Apache Kafka® cluster the user belongs to. ||
|| user_name | **string**

Name of the user that is being updated. ||
|#

## User {#yandex.cloud.mdb.kafka.v1.User}

A Kafka user.
For more information, see the [Operations -> Accounts](/docs/managed-kafka/operations/cluster-accounts) section of the documentation.

#|
||Field | Description ||
|| name | **string**

Name of the Kafka user. ||
|| cluster_id | **string**

ID of the Apache Kafka® cluster the user belongs to.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.kafka.v1.Permission2)**

Set of permissions granted to this user. ||
|#

## Permission {#yandex.cloud.mdb.kafka.v1.Permission2}

#|
||Field | Description ||
|| topic_name | **string**

Name or prefix-pattern with wildcard for the topic that the permission grants access to.

To get the topic name, make a [TopicService.List](/docs/managed-kafka/api-ref/grpc/Topic/list#List) request. ||
|| role | enum **AccessRole**

Access role type to grant to the user.

- `ACCESS_ROLE_UNSPECIFIED`
- `ACCESS_ROLE_PRODUCER`: Producer role for the user.
- `ACCESS_ROLE_CONSUMER`: Consumer role for the user.
- `ACCESS_ROLE_ADMIN`: Admin role for the user. ||
|| allow_hosts[] | **string**

Lists hosts allowed for this permission.
Only ip-addresses allowed as value of single host.
When not defined, access from any host is allowed.

Bare in mind that the same host might appear in multiple permissions at the same time,
hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission.
If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. ||
|#