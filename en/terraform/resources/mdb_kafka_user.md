---
subcategory: Managed Service for Apache Kafka®
---

# yandex_mdb_kafka_user (Resource)

Manages a user of a Kafka User within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts).

## Example usage

```terraform
//
// Create a new MDB Kafka User.
//
resource "yandex_mdb_kafka_user" "user_events" {
  cluster_id = yandex_mdb_kafka_cluster.foo.id
  name       = "user-events"
  password   = "pass1231232332"
  permission {
    topic_name  = "events"
    role        = "ACCESS_ROLE_CONSUMER"
    allow_hosts = ["host1.db.yandex.net", "host2.db.yandex.net"]
  }
  permission {
    topic_name = "events"
    role       = "ACCESS_ROLE_PRODUCER"
  }
}

// Auxiliary resources
resource "yandex_mdb_kafka_topic" "events" {
  cluster_id         = yandex_mdb_kafka_cluster.my_cluster.id
  name               = "events"
  partitions         = 4
  replication_factor = 1
}

resource "yandex_mdb_kafka_cluster" "my_cluster" {
  name       = "foo"
  network_id = "c64vs98keiqc7f24pvkd"

  config {
    version = "2.8"
    zones   = ["ru-central1-a"]
    kafka {
      resources {
        resource_preset_id = "s2.micro"
        disk_type_id       = "network-hdd"
        disk_size          = 16
      }
    }
  }
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

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_kafka_user.<resource Name> <resource Id>
terraform import yandex_mdb_kafka_user.user_events ...
```
