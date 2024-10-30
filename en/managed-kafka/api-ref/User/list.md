---
editable: false
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/User/list.md
---

# Managed Service for Apache Kafka® API, REST: User.List {#List}

Retrieves the list of Kafka users in the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster to list Kafka users in.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.kafka.v1.ListUsersRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.kafka.v1.ListUsersResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.

To get the next page of results, set `pageToken` to the [ListUsersResponse.nextPageToken](#yandex.cloud.mdb.kafka.v1.ListUsersResponse) returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.kafka.v1.ListUsersResponse}

**HTTP Code: 200 - OK**

```json
{
  "users": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.kafka.v1.User)**

List of Kafka users. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListUsersRequest.pageSize](#yandex.cloud.mdb.kafka.v1.ListUsersRequest), use the `nextPageToken` as the value for the [ListUsersRequest.pageToken](#yandex.cloud.mdb.kafka.v1.ListUsersRequest) parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
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
|| permissions[] | **[Permission](#yandex.cloud.mdb.kafka.v1.Permission)**

Set of permissions granted to this user. ||
|#

## Permission {#yandex.cloud.mdb.kafka.v1.Permission}

#|
||Field | Description ||
|| topicName | **string**

Name or prefix-pattern with wildcard for the topic that the permission grants access to.

To get the topic name, make a [TopicService.List](/docs/managed-kafka/api-ref/Topic/list#List) request. ||
|| role | **enum** (AccessRole)

Access role type to grant to the user.

- `ACCESS_ROLE_UNSPECIFIED`
- `ACCESS_ROLE_PRODUCER`: Producer role for the user.
- `ACCESS_ROLE_CONSUMER`: Consumer role for the user.
- `ACCESS_ROLE_ADMIN`: Admin role for the user. ||
|| allowHosts[] | **string**

Lists hosts allowed for this permission.
Only ip-addresses allowed as value of single host.
When not defined, access from any host is allowed.

Bare in mind that the same host might appear in multiple permissions at the same time,
hence removing individual permission doesn't automatically restricts access from the `allowHosts` of the permission.
If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. ||
|#