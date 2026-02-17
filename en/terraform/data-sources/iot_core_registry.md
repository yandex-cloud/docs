---
subcategory: Cloud Logging
---

# yandex_iot_core_registry (DataSource)

Get information about a Yandex IoT Core Registry. For more information IoT Core, see [Yandex Cloud IoT Registry](https://yandex.cloud/docs/iot-core/quickstart).
This data source is used to define [Yandex Cloud IoT Registry](https://yandex.cloud/docs/iot-core/quickstart) that can be used by other resources.

{% note warning %}

Either `registry_id` or `name` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing IoT Core Registry.
//
data "yandex_iot_core_registry" "my_registry" {
  registry_id = "are1sampleregistry11"
}
```

## Arguments & Attributes Reference

- `certificates` (Set Of String). A set of certificate's fingerprints for the IoT Core Registry.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_options` [Block]. Options for logging for IoT Core Registry.
  - `disabled` (Bool). Is logging for registry disabled.
  - `folder_id` (String). Log entries are written to default log group for specified folder.
  - `log_group_id` (String). Log entries are written to specified log group.
  - `min_level` (String). Minimum log entry level.
- `name` (**Required**)(String). The resource name.
- `passwords` (Set Of String). A set of passwords's id for the IoT Core Registry.
- `registry_id` (String). IoT Core Registry id used to define registry.


