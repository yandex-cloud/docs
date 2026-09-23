[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > IoT Core Devices > Data Sources > iot_core_registry

# yandex_iot_core_registry (DataSource)

Get information about a Yandex IoT Core Registry. For more information IoT Core, see [Yandex Cloud IoT Registry](../../iot-core/quickstart.md).
This data source is used to define [Yandex Cloud IoT Registry](../../iot-core/quickstart.md) that can be used by other resources.

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

- `certificates` (*Read-Only*) (Set Of String). A set of certificate's fingerprints for the IoT Core Registry.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_options` (*Read-Only*) (List Of Object). 
  - `disabled` . 
  - `folder_id` . 
  - `log_group_id` . 
  - `min_level` . 
- `name` (String). The resource name.
- `passwords` (*Read-Only*) (Set Of String). A set of passwords's id for the IoT Core Registry.
- `registry_id` (String). IoT Core Registry id used to define registry.