---
subcategory: Managed Service for ValKey
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_redis_user.md
---

# yandex_mdb_redis_user (DataSource)

Manages a Redis user within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-redis/).

## Example usage

```terraform
//
// Get information about existing MDB Redis User.
//
data "yandex_mdb_redis_user" "my_user" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "permissions" {
  value = data.yandex_mdb_redis_user.my_user.permissions
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


