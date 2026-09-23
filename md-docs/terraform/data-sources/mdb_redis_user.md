[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for ValKey > Data Sources > mdb_redis_user

# yandex_mdb_redis_user (DataSource)

Manages a Redis user within the Yandex Cloud. For more information, see [the official documentation](../../managed-redis).

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
- `enabled` (*Read-Only*) (Bool). Is redis user enabled.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the user.
- `passwords` (*Read-Only*) (Set Of String). Set of user passwords
- `permissions` [Block]. Set of permissions granted to the user.
  - `categories` (*Read-Only*) (String). Command categories user has permissions to.
  - `commands` (*Read-Only*) (String). Commands user can execute.
  - `databases` (*Read-Only*) (String). Databases user has access to.
  - `patterns` (*Read-Only*) (String). Keys patterns user has permission to.
  - `pub_sub_channels` (*Read-Only*) (String). Channel patterns user has permissions to.
  - `sanitize_payload` (*Read-Only*) (String). Deprecated. This parameter no longer affects user permissions.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).