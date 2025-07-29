---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/User/get.md
---

# Managed Service for Apache Kafka® API, gRPC: UserService.Get

Returns the specified Kafka user.

To get the list of available Kafka users, make a [List](/docs/managed-kafka/api-ref/grpc/User/list#List) request.

## gRPC request

**rpc Get ([GetUserRequest](#yandex.cloud.mdb.kafka.v1.GetUserRequest)) returns ([User](#yandex.cloud.mdb.kafka.v1.User))**

## GetUserRequest {#yandex.cloud.mdb.kafka.v1.GetUserRequest}

```json
{
  "cluster_id": "string",
  "user_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Apache Kafka® cluster the user belongs to.

To get the cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| user_name | **string**

Required field. Name of the Kafka user to return.

To get the name of the user, make a [UserService.List](/docs/managed-kafka/api-ref/grpc/User/list#List) request. ||
|#

## User {#yandex.cloud.mdb.kafka.v1.User}

```json
{
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
```

A Kafka user.
For more information, see the [Operations -> Accounts](/docs/managed-kafka/operations/cluster-accounts) section of the documentation.

#|
||Field | Description ||
|| name | **string**

Name of the Kafka user. ||
|| cluster_id | **string**

ID of the Apache Kafka® cluster the user belongs to.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.kafka.v1.Permission)**

Set of permissions granted to this user. ||
|#

## Permission {#yandex.cloud.mdb.kafka.v1.Permission}

#|
||Field | Description ||
|| topic_name | **string**

Name or prefix-pattern with wildcard for the topic that the permission grants access to.
With roles SCHEMA_READER and SCHEMA_WRITER: string that contains set of schema registry subjects, separated by ';'.

To get the topic name, make a [TopicService.List](/docs/managed-kafka/api-ref/grpc/Topic/list#List) request. ||
|| role | enum **AccessRole**

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
|| allow_hosts[] | **string**

Lists hosts allowed for this permission.
Only ip-addresses allowed as value of single host.
When not defined, access from any host is allowed.

Bare in mind that the same host might appear in multiple permissions at the same time,
hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission.
If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. ||
|#