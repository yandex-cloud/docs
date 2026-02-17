---
subcategory: Managed Service for ClickHouse
---

# yandex_mdb_clickhouse_database (Resource)

A database of the ClickHouse cluster.

## Example usage

```terraform
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

resource "yandex_mdb_clickhouse_cluster" "foo" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 32
  }

  config {
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.foo.id
  }

  service_account_id = "your_service_account_id"

  maintenance_window {
    type = "ANYTIME"
  }

  lifecycle {
    ignore_changes = [database, user, ]
  }
}

resource "yandex_mdb_clickhouse_database" "foo" {
  cluster_id = yandex_mdb_clickhouse_cluster.foo.id
  name       = "database1"
}

resource "yandex_mdb_clickhouse_database" "bar" {
  cluster_id = yandex_mdb_clickhouse_cluster.foo.id
  name       = "database2"
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). ID of the ClickHouse cluster. Provided by the client when the database is created.
- `engine` (String). Database engine, possible values are: atomic,replicated.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the database.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_clickhouse_database.<resource Name> <resource Id>
terraform import yandex_mdb_clickhouse_database.my_db1 cluster_id:my_dbname
```
