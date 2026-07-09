[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for MongoDB > Resources > mdb_mongodb_user

# yandex_mdb_mongodb_user (Resource)

Manages a MongoDB user within the Yandex Cloud. For more information, see [the official documentation](../../managed-mongodb).

## Example usage

```terraform
//
// Create a new MDB MongoDB User.
//
resource "yandex_mdb_mongodb_user" "my_user" {
  cluster_id = yandex_mdb_mongodb_cluster.my_cluster.id
  name       = "alice"
  password   = "password"
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
```terraform
//
// Create a new MDB MongoDB user authenticated via IAM.
//
// An IAM user is identified by the ID of an IAM subject (for example, a
// service account) and authenticates with IAM tokens, so it has no password.
//
resource "yandex_iam_service_account" "my_sa" {
  name = "mongodb-iam-user"
}

resource "yandex_mdb_mongodb_user" "my_iam_user" {
  cluster_id = yandex_mdb_mongodb_cluster.my_cluster.id
  name       = yandex_iam_service_account.my_sa.id
  auth_type  = "IAM"

  permission {
    database_name = "db1"
    roles         = ["readWrite"]
  }
}
```

## Arguments & Attributes Reference

- `auth_type` (String). The authentication type of the user. Either `PASSWORD` (default) or `IAM`.
- `cluster_id` (**Required**)(String). The ID of the cluster to which user belongs to.
- `deletion_protection` (Bool). Inhibits deletion of the user.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the user.
- `password` (String). The password of the user. Required for users with `PASSWORD` authentication and must be omitted for users with `IAM` authentication.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `permission` [Block]. Set of permissions granted to the user.
  - `database_name` (**Required**)(String). The name of the database that the permission grants access to.
  - `roles` (Set Of String). The roles of the user in this database. For more information see [the official documentation](../../storedoc/concepts/users-and-roles.md).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_mdb_mongodb_user.<resource Name> <cluster_id>:<database_name>
terraform import yandex_mdb_mongodb_user.my_user ...:my_user
```