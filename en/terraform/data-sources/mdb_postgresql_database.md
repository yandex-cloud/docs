---
subcategory: Managed Service for PostgreSQL
---

# yandex_mdb_postgresql_database (DataSource)

Get information about a Yandex Managed PostgreSQL database. For more information, see [the official documentation](https://yandex.cloud/docs/managed-postgresql/).

## Example usage

```terraform
//
// Get information about existing MDB PostgreSQL Database.
//
data "yandex_mdb_postgresql_database" "foo" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "owner" {
  value = data.yandex_mdb_postgresql_database.foo.owner
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the PostgreSQL cluster.
- `deletion_protection` (String). The `true` value means that resource is protected from accidental deletion.
- `extension` [Block]. Set of database extensions.
  - `name` (**Required**)(String). Name of the database extension. For more information on available extensions see [the official documentation](https://yandex.cloud/docs/managed-postgresql/operations/cluster-extensions).
- `id` (String). 
- `lc_collate` (String). POSIX locale for string sorting order. Forbidden to change in an existing database.
- `lc_type` (String). POSIX locale for character classification. Forbidden to change in an existing database.
- `name` (**Required**)(String). The name of the PostgreSQL database.
- `owner` (**Required**)(String). Name of the user assigned as the owner of the database. Forbidden to change in an existing database.
- `template_db` (String). Name of the template database.


