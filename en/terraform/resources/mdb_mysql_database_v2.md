---
subcategory: Managed Service for MySQL
---

# yandex_mdb_mysql_database_v2 (Resource)

Manages a MySQL database within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/ru/docs/managed-mysql/operations/databases).


## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). ID of the MySQL cluster. Provided by the client when the database is created.
- `deletion_protection_mode` (String). Deletion Protection inhibits deletion of the database. Possible values: DELETION_PROTECTION_MODE_DISABLED (default), DELETION_PROTECTION_MODE_ENABLED, DELETION_PROTECTION_MODE_INHERITED.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the database.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


