[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Apache Kafka®](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [User](index.md) > Get

# Managed Service for Apache Kafka® API, REST: User.Get

Returns the specified Kafka user.
To get the list of available Kafka users, make a [List](list.md#List) request.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/users/{userName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster the user belongs to.
To get the cluster ID, make a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| userName | **string**

Required field. Name of the Kafka user to return.
To get the name of the user, make a [UserService.List](list.md#List) request.

The string length in characters must be 1-63. Value must match the regular expression ` [a-zA-Z0-9_]* `. ||
|#

## Response {#yandex.cloud.mdb.kafka.v1.User}

**HTTP Code: 200 - OK**

```json
{
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
```

A Kafka user.
For more information, see the [Operations -> Accounts](../../operations/cluster-accounts.md) section of the documentation.

#|
||Field | Description ||
|| name | **string**

Name of the Kafka user. ||
|| clusterId | **string**

ID of the Apache Kafka® cluster the user belongs to.
To get the Apache Kafka® cluster ID, make a [ClusterService.List](../Cluster/list.md#List) request. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.kafka.v1.Permission)**

Set of permissions granted to this user. ||
|#

## Permission {#yandex.cloud.mdb.kafka.v1.Permission}

#|
||Field | Description ||
|| topicName | **string**

Name or prefix-pattern with wildcard for the topic that the permission grants access to.
With roles SCHEMA_READER and SCHEMA_WRITER: string that contains set of schema registry subjects, separated by ';'.
To get the topic name, make a [TopicService.List](../Topic/list.md#List) request. ||
|| role | **enum** (AccessRole)

Access role type to grant to the user.

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