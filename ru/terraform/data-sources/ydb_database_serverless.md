---
subcategory: Managed Service for YDB
---

# yandex_ydb_database_serverless (DataSource)

Get information about a Yandex Database serverless cluster. For more information, see [the official documentation](https://yandex.cloud/docs/ydb/concepts/serverless_and_dedicated).

{% note warning %}

If `database_id` is not specified `name` and `folder_id` will be used to designate Yandex Database serverless cluster.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing YDB Serverless Database.
//
data "yandex_ydb_database_serverless" "my_database" {
  database_id = "some_ydb_serverless_database_id"
}

output "ydb_api_endpoint" {
  value = data.yandex_ydb_database_serverless.my_database.ydb_api_endpoint
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `database_id` (String). ID of the Yandex Database serverless cluster.
- `database_path` (*Read-Only*) (String). Full database path of the Yandex Database serverless cluster. Useful for SDK configuration.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `document_api_endpoint` (*Read-Only*) (String). Document API endpoint of the Yandex Database serverless cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `location_id` (String). Location ID for the Yandex Database serverless cluster.
- `name` (**Required**)(String). The resource name.
- `status` (*Read-Only*) (String). Status of the Yandex Database serverless cluster.
- `tls_enabled` (*Read-Only*) (Bool). Whether TLS is enabled for the Yandex Database serverless cluster. Useful for SDK configuration.
- `ydb_api_endpoint` (*Read-Only*) (String). API endpoint of the Yandex Database serverless cluster. Useful for SDK configuration.
- `ydb_full_endpoint` (*Read-Only*) (String). Full endpoint of the Yandex Database serverless cluster.
- `serverless_database` [Block]. 
  - `enable_throttling_rcu_limit` (Bool). 
  - `provisioned_rcu_limit` (Number). 
  - `storage_size_limit` (Number). 
  - `throttling_rcu_limit` (Number).


