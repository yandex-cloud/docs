---
subcategory: Cloud Logging
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/iot_core_broker.md
---

# yandex_iot_core_broker (DataSource)

Get information about a Yandex IoT Core Broker. For more information IoT Core, see [Yandex Cloud IoT Broker](https://yandex.cloud/docs/iot-core/quickstart).
This data source is used to define [Yandex Cloud IoT Broker](https://yandex.cloud/docs/iot-core/quickstart) that can be used by other resources.

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
- `certificates` (Set Of String). A set of certificate's fingerprints for the IoT Core Broker.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_options` [Block]. Options for logging for IoT Core Broker.
  - `disabled` (Bool). Is logging for broker disabled.
  - `folder_id` (String). Log entries are written to default log group for specified folder.
  - `log_group_id` (String). Log entries are written to specified log group.
  - `min_level` (String). Minimum log entry level.
- `name` (**Required**)(String). The resource name.


