---
subcategory: Managed Service for Apache Kafka®
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_kafka_user.md
---

# yandex_mdb_kafka_user (DataSource)

Get information about a user of the Yandex Managed Kafka cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts).

## Example usage

```terraform
//
// Get information about existing MDB Kafka User.
//
data "yandex_mdb_kafka_user" "my_user" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "username" {
  value = data.yandex_mdb_kafka_user.my_user.name
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the Kafka cluster.
- `id` (String). 
- `name` (**Required**)(String). The resource name.
- `password` (**Required**)(String). The password of the user.
- `permission` [Block]. Set of permissions granted to the user.
  - `allow_hosts` (Set Of String). Set of hosts, to which this permission grants access to. Only ip-addresses allowed as value of single host.
  - `role` (**Required**)(String). The role type to grant to the topic.
  - `topic_name` (**Required**)(String). The name of the topic that the permission grants access to.


