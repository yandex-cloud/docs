---
subcategory: Managed Service for MongoDB
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_mongodb_database.md
---

# yandex_mdb_mongodb_database (Resource)

Manages a MongoDB Database within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-mongodb/).

## Example usage

```terraform
//
// Create a new MDB MongoDB Database.
//
resource "yandex_mdb_mongodb_database" "my_db" {
  cluster_id = yandex_mdb_mongodb_cluster.my_cluster.id
  name       = "testdb"
}

resource "yandex_mdb_mongodb_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  cluster_config {
    version = "6.0"
  }

  host {
    zone_id   = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.foo.id
  }
  resources_mongod {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of MongoDB Cluster.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the database.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_mongodb_database.<resource Name> <cluster_id>:<database_name>
terraform import yandex_mdb_mongodb_database.my_db ...:my_db
```
