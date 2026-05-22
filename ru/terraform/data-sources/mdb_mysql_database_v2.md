---
subcategory: Managed Service for MySQL
---

# yandex_mdb_mysql_database_v2 (DataSource)

Get information about a Yandex Managed MySQL database.


## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). ID of the MySQL cluster. Provided by the client when the database is created.
- `deletion_protection_mode` (String). Deletion Protection inhibits deletion of the database. Possible values: DELETION_PROTECTION_MODE_DISABLED (default), DELETION_PROTECTION_MODE_ENABLED, DELETION_PROTECTION_MODE_INHERITED.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the database.
- `timeouts` [Block]. 
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.


