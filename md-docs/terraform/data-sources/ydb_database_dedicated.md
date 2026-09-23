[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for YDB > Data Sources > ydb_database_dedicated

# yandex_ydb_database_dedicated (DataSource)

Get information about a Yandex Database (dedicated) cluster. For more information, see [the official documentation](../../ydb/concepts/serverless_and_dedicated).

{% note warning %}

If `database_id` is not specified `name` and `folder_id` will be used to designate Yandex Database cluster.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing YDB Dedicated Database.
//
data "yandex_ydb_database_dedicated" "my_database" {
  database_id = "some_ydb_dedicated_database_id"
}

output "ydb_api_endpoint" {
  value = data.yandex_ydb_database_dedicated.my_database.ydb_api_endpoint
}
```

## Arguments & Attributes Reference

- `assign_public_ips` (*Read-Only*) (Bool). Whether public IP addresses should be assigned to the Yandex Database cluster.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `database_id` (String). ID of the Yandex Database cluster.
- `database_path` (*Read-Only*) (String). Full database path of the Yandex Database cluster. Useful for SDK configuration.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `location` (*Read-Only*) (List Of Object). Location for the Yandex Database cluster.
  - `region` . 
    - `id` . 
- `location_id` (*Read-Only*) (String). Location ID for the Yandex Database cluster.
- `name` (String). The resource name.
- `network_id` (*Read-Only*) (String). The `VPC Network ID` of subnets which resource attached to.
- `resource_preset_id` (*Read-Only*) (String). The Yandex Database cluster preset. Available presets can be obtained via `yc ydb resource-preset list` command.
- `scale_policy` (*Read-Only*) (List Of Object). Scaling policy for the Yandex Database cluster.
  - `auto_scale` . 
    - `max_size` . 
    - `min_size` . 
    - `target_tracking` . 
      - `cpu_utilization_percent` . 
  - `fixed_scale` . 
    - `size` . 
- `security_group_ids` (*Read-Only*) (Set Of String). The list of security groups applied to resource or their components.
- `status` (*Read-Only*) (String). Status of the Yandex Database cluster.
- `storage_config` (*Read-Only*) (List Of Object). A list of storage configuration options for the Yandex Database cluster.
  - `group_count` . 
  - `storage_type_id` . 
- `subnet_ids` (*Read-Only*) (Set Of String). The list of VPC subnets identifiers which resource is attached.
- `tls_enabled` (*Read-Only*) (Bool). Whether TLS is enabled for the Yandex Database cluster. Useful for SDK configuration.
- `ydb_api_endpoint` (*Read-Only*) (String). API endpoint of the Yandex Database cluster. Useful for SDK configuration.
- `ydb_full_endpoint` (*Read-Only*) (String). Full endpoint of the Yandex Database cluster.