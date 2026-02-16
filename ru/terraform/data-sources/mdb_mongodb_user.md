---
subcategory: Managed Service for MongoDB
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_mongodb_user.md
---

# yandex_mdb_mongodb_user (DataSource)

Manages a MongoDB user within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-mongodb/).

## Example usage

```terraform
//
// Get information about existing MDB MongoDB User.
//
data "yandex_mdb_mongodb_user" "my_user" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "permission" {
  value = data.yandex_mdb_mongodb_user.my_user.permission
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the cluster to which user belongs to.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the user.
- `password` (**Required**)(String). The password of the user.
- `permission` [Block]. Set of permissions granted to the user.
  - `database_name` (**Required**)(String). The name of the database that the permission grants access to.
  - `roles` (Set Of String). The roles of the user in this database. For more information see [the official documentation](https://yandex.cloud/docs/managed-mongodb/concepts/users-and-roles).


