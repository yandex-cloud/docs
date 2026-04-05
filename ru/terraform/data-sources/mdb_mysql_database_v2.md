---
subcategory: Managed Service for MySQL
---

# yandex_mdb_mysql_database_v2 (DataSource)

Get information about a Yandex Managed MySQL database. For more information, see [the official documentation](https://yandex.cloud/ru/docs/managed-mysql/operations/databases).

## Example usage

```terraform
data "yandex_mdb_mysql_database_v2" "my_db" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "deletion_protection" {
  value = data.yandex_mdb_mysql_database_v2.my_db.deletion_protection_mode
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the MySQL cluster.
- `deletion_protection_mode` (*Read-Only*)(String). Deletion Protection inhibits deletion of the database. Possible values: `DELETION_PROTECTION_MODE_DISABLED`, `DELETION_PROTECTION_MODE_ENABLED`, `DELETION_PROTECTION_MODE_INHERITED`.
- `id` (*Read-Only*)(String). The resource identifier.
- `name` (**Required**)(String). The name of the database.
