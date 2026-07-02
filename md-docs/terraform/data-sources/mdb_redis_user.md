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
- `enabled` (Bool). Is redis user enabled.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the user.
- `passwords` (**Required**)(Set Of String). Set of user passwords
- `permissions` [Block]. Set of permissions granted to the user.
  - `categories` (String). Command categories user has permissions to.
  - `commands` (String). Commands user can execute.
  - `databases` (String). Databases user has access to. Accepts "alldbs", "resetdbs", or comma-separated list of database numbers (e.g. "0,1,5").
  - `patterns` (String). Keys patterns user has permission to.
  - `pub_sub_channels` (String). Channel patterns user has permissions to.
  - `sanitize_payload` (String). SanitizePayload parameter.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).