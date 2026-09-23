---
subcategory: DataLens
---

# yandex_datalens_connection (DataSource)

Retrieves information about a DataLens connection. For more information, see [the official documentation](https://yandex.cloud/ru/docs/datalens/operations/api-start).


## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The description of the connection.
- `id` (**Required**)(String). The ID of the connection.
- `name` (*Read-Only*) (String). The name of the connection.
- `organization_id` (String). The organization ID for the DataLens instance. If not specified, the provider-level `organization_id` is used.
- `type` (*Read-Only*) (String). The connection type.
- `updated_at` (*Read-Only*) (String). The last update timestamp of the resource.
- `ydb` [Block]. YDB connection configuration. Populated when `type` is `ydb`.
  - `auth_type` (*Read-Only*) (String). The authentication type for the connection.
  - `cache_ttl_sec` (*Read-Only*) (Number). The cache TTL in seconds.
  - `cloud_id` (*Read-Only*) (String). The cloud ID where the YDB database is located.
  - `data_export_forbidden` (*Read-Only*) (String). Whether data export is forbidden.
  - `db_name` (*Read-Only*) (String). The YDB database name (path).
  - `delegation_is_set` (*Read-Only*) (Bool). Whether delegation is configured for the connection.
  - `dir_path` (*Read-Only*) (String). The directory path where the connection entry is stored.
  - `folder_id` (*Read-Only*) (String). The folder ID where the YDB database is located.
  - `host` (*Read-Only*) (String). The hostname of the YDB database endpoint.
  - `mdb_cluster_id` (*Read-Only*) (String). The Managed Databases cluster ID.
  - `mdb_folder_id` (*Read-Only*) (String). The folder ID for Managed Databases cluster lookup.
  - `port` (*Read-Only*) (Number). The port number of the YDB database endpoint.
  - `raw_sql_level` (*Read-Only*) (String). The level of raw SQL queries allowed.
  - `service_account_id` (*Read-Only*) (String). The service account ID used to access the YDB database.
  - `ssl_enable` (*Read-Only*) (String). Whether SSL is enabled for the connection.
  - `username` (*Read-Only*) (String). The username for authentication.
  - `workbook_id` (*Read-Only*) (String). The workbook ID where the connection is stored.


