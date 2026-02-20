---
subcategory: DataLens
---

# yandex_datalens_connection (DataSource)

Retrieves information about a DataLens connection. For more information, see [the official documentation](https://yandex.cloud/ru/docs/datalens/operations/api-start).


## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The resource name. Changing this attribute forces recreation of the resource.
- `organization_id` (String). The organization ID for the DataLens instance. If not specified, the provider-level `organization_id` is used.
- `type` (**Required**)(String). The connection type. Currently supported: `ydb`. Changing this attribute forces recreation of the resource.
- `updated_at` (*Read-Only*) (String). The last update timestamp of the resource.
- `ydb` [FW-Block]. Configuration for YDB connection type. Must be specified when `type` is `ydb`.
  - `auth_type` (String). The authentication type for the connection. Possible values: `anonymous`, `password`, `oauth`.
  - `cache_ttl_sec` (Number). The cache TTL in seconds. `null` means default caching behavior.
  - `cloud_id` (**Required**)(String). The cloud ID where the YDB database is located.
  - `data_export_forbidden` (String). Whether data export is forbidden. Possible values: `on`, `off`. Defaults to `off`.
  - `db_name` (**Required**)(String). The YDB database name (path).
  - `delegation_is_set` (Bool). Whether delegation is configured for the connection.
  - `dir_path` (String). The directory path where the connection entry will be stored (used when connections are organized in folders instead of workbooks). Either `workbook_id` or `dir_path` must be specified. Changing this attribute forces recreation of the resource.
  - `folder_id` (**Required**)(String). The folder ID where the YDB database is located.
  - `host` (**Required**)(String). The hostname of the YDB database endpoint.
  - `mdb_cluster_id` (String). The Managed Databases cluster ID (for managed YDB instances).
  - `mdb_folder_id` (String). The folder ID for Managed Databases cluster lookup.
  - `port` (**Required**)(Number). The port number of the YDB database endpoint.
  - `raw_sql_level` (String). The level of raw SQL queries allowed. Possible values: `off`, `subselect`, `template`, `dashsql`. Defaults to `off`.
  - `service_account_id` (**Required**)(String). The service account ID used to access the YDB database.
  - `ssl_ca` (String). The SSL CA certificate for secure connections.
  - `ssl_enable` (String). Whether SSL is enabled for the connection. Possible values: `on`, `off`. Defaults to `on`.
  - `token` (String). The OAuth token for authentication (used when `auth_type` is `oauth`). This is a write-only field and will not be returned by the API.
  - `username` (String). The username for authentication (used when `auth_type` is `password`).
  - `workbook_id` (String). The workbook ID where the connection will be created. Either `workbook_id` or `dir_path` must be specified. Changing this attribute forces recreation of the resource.


