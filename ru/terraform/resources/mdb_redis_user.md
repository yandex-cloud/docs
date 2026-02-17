---
subcategory: Managed Service for ValKey
---

# yandex_mdb_redis_user (Resource)

Manages a Redis user within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-redis/).

## Example usage

```terraform
//
// Create a new MDB Redis User.
//
resource "yandex_mdb_redis_user" "my_user" {
  cluster_id = yandex_mdb_redis_cluster_v2.my_cluster.id
  name       = "alice"
  passwords  = ["password"]
}

resource "yandex_mdb_redis_cluster_v2" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config = {
    password = "your_password"
    version  = "7.2-valkey"
  }

  resources = {
    resource_preset_id = "hm1.nano"
    disk_size          = 16
  }

  hosts = {
    "aaa" = {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.foo.id
    }
  }

  maintenance_window = {
    type = "ANYTIME"
  }
}

resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
```

## Arguments & Attributes Reference

- `acl_options` (*Read-Only*) (String). Raw ACL string which has been inserted into the Redis
- `cluster_id` (**Required**)(String). The ID of the cluster to which user belongs to.
- `enabled` (Bool). Is redis user enabled.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the user.
- `passwords` (**Required**)(Set Of String). Set of user passwords
- `permissions` [Block]. Set of permissions granted to the user.
  - `categories` (String). Command categories user has permissions to.
  - `commands` (String). Commands user can execute.
  - `patterns` (String). Keys patterns user has permission to.
  - `pub_sub_channels` (String). Channel patterns user has permissions to.
  - `sanitize_payload` (String). SanitizePayload parameter.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_redis_user.<resource Name> <cluster_id>:<database_name>
terraform import yandex_mdb_redis_user.my_user ...:my_user
```
