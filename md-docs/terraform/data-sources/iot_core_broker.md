[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > IoT Core Broker > Data Sources > iot_core_broker

# yandex_iot_core_broker (DataSource)

Get information about a Yandex IoT Core Broker. For more information IoT Core, see [Yandex Cloud IoT Broker](../../iot-core/quickstart.md).
This data source is used to define [Yandex Cloud IoT Broker](../../iot-core/quickstart.md) that can be used by other resources.

{% note warning %}

Either `broker_id` or `name` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing IoT Core Broker.
//
data "yandex_iot_core_broker" "my_broker" {
  broker_id = "are1samplebroker11"
}
```

## Arguments & Attributes Reference

- `broker_id` (String). IoT Core Broker id used to define broker.
- `certificates` (*Read-Only*) (Set Of String). A set of certificate's fingerprints for the IoT Core Broker.
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