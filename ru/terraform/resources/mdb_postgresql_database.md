---
subcategory: Managed Service for PostgreSQL
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_postgresql_database.md
---

# yandex_mdb_postgresql_database (Resource)

Manages a PostgreSQL database within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-postgresql/).

## Example usage

```terraform
//
// Create a new MDB PostgreSQL Database.
//
resource "yandex_mdb_postgresql_database" "my_db" {
  cluster_id = yandex_mdb_postgresql_cluster.my_cluster.id
  name       = "testdb"
  owner      = yandex_mdb_postgresql_user.my_user.name
  lc_collate = "en_US.UTF-8"
  lc_type    = "en_US.UTF-8"
  extension {
    name = "uuid-ossp"
  }
  extension {
    name = "xml2"
  }
}

resource "yandex_mdb_postgresql_user" "my_user" {
  cluster_id = yandex_mdb_postgresql_cluster.my_cluster.id
  name       = "alice"
  password   = "password"
}

resource "yandex_mdb_postgresql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config {
    version = 15
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }
  }

  host {
    zone      = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.foo.id
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

- `cluster_id` (**Required**)(String). The ID of the PostgreSQL cluster.
- `deletion_protection` (String). The `true` value means that resource is protected from accidental deletion.
- `id` (String). 
- `lc_collate` (String). POSIX locale for string sorting order. Forbidden to change in an existing database.
- `lc_type` (String). POSIX locale for character classification. Forbidden to change in an existing database.
- `name` (**Required**)(String). The name of the PostgreSQL database.
- `owner` (**Required**)(String). Name of the user assigned as the owner of the database. Forbidden to change in an existing database.
- `template_db` (String). Name of the template database.
- `extension` [Block]. Set of database extensions.
  - `name` (**Required**)(String). Name of the database extension. For more information on available extensions see [the official documentation](https://yandex.cloud/docs/managed-postgresql/operations/cluster-extensions).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_postgresql_database.<resource Name> <resource Id>
terraform import yandex_mdb_postgresql_database.my_db ...
```
