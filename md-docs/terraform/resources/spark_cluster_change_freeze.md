[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Spark > Resources > spark_cluster_change_freeze

# yandex_spark_cluster_change_freeze (Resource)



## Example usage

```terraform
resource "yandex_spark_cluster_change_freeze" "example" {
  resource_id = yandex_spark_cluster.example.id
  start_at    = "2026-11-26T00:00:00Z"
  end_at      = "2026-12-01T00:00:00Z"
  reason      = "Black Friday"
}
```

## Arguments & Attributes Reference

- `change_freeze_id` (String). ID of the change freeze to retrieve.
- `created_at` (*Read-Only*) (String). The creation time of the change freeze.
- `created_by` (*Read-Only*) (String). The user who created the change freeze.
- `duration_seconds` (*Read-Only*) (Number). Duration of the change freeze in seconds.
- `end_at` (**Required**)(String). The time when the change freeze is scheduled to end.
- `id` (String). ID of the change freeze to retrieve.
- `reason` (String). Reason for the change freeze.
- `resource_id` (**Required**)(String). ID of the resource to create a change freeze for.
- `start_at` (**Required**)(String). The time when the change freeze is scheduled to start.
- `status` (*Read-Only*) (String). Status of the change freeze.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `updated_at` (*Read-Only*) (String). The time when the change freeze was last updated.
- `updated_by` (*Read-Only*) (String). The user who last updated the change freeze.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_spark_cluster_change_freeze.<resource Name> <resource_id>:<change_freeze_id>
terraform import yandex_spark_cluster_change_freeze.example c9q-resource-id:change-freeze-id
```