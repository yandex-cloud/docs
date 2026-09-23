---
subcategory: Managed Service for Apache Kafka®
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
- `password` (*Read-Only*) (String). The password of the user.
- `permission` (*Read-Only*) (Set Of Object). Set of permissions granted to the user.
  - `allow_hosts` . 
  - `role` . 
  - `topic_name` .


