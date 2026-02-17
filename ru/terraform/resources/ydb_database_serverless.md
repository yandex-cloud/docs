---
subcategory: Managed Service for YDB
---

# yandex_ydb_database_serverless (Resource)

Yandex Database (serverless) resource. For more information, see [the official documentation](https://yandex.cloud/docs/ydb/concepts/serverless_and_dedicated).

## Example usage

```terraform
//
// Create a new YDB Serverless Database.
//
resource "yandex_ydb_database_serverless" "my_ydb" {
  name      = "test-ydb-serverless"
  folder_id = data.yandex_resourcemanager_folder.test_folder.id

  deletion_protection = true
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `database_path` (*Read-Only*) (String). Full database path of the Yandex Database serverless cluster. Useful for SDK configuration.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `document_api_endpoint` (*Read-Only*) (String). Document API endpoint of the Yandex Database serverless cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `location_id` (String). Location ID for the Yandex Database serverless cluster.
- `name` (**Required**)(String). The resource name.
- `sleep_after` (Number). 
- `status` (*Read-Only*) (String). Status of the Yandex Database serverless cluster.
- `tls_enabled` (*Read-Only*) (Bool). Whether TLS is enabled for the Yandex Database serverless cluster. Useful for SDK configuration.
- `ydb_api_endpoint` (*Read-Only*) (String). API endpoint of the Yandex Database serverless cluster. Useful for SDK configuration.
- `ydb_full_endpoint` (*Read-Only*) (String). Full endpoint of the Yandex Database serverless cluster.
- `serverless_database` [Block]. 
  - `enable_throttling_rcu_limit` (Bool). 
  - `provisioned_rcu_limit` (Number). 
  - `storage_size_limit` (Number). 
  - `throttling_rcu_limit` (Number).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_ydb_database_serverless.<resource Name> <resource Id>
terraform import yandex_ydb_database_serverless.my_ydb ...
```
