---
subcategory: Cloud Logging
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/iot_core_broker.md
---

# yandex_iot_core_broker (Resource)

Allows management of [Yandex Cloud IoT Broker](https://yandex.cloud/docs/iot-core/quickstart).

## Example usage

```terraform
//
// Create a new IoT Core Broker.
//
resource "yandex_iot_core_broker" "my_broker" {
  name        = "some_name"
  description = "any description"
  labels = {
    my-label = "my-label-value"
  }
  log_options {
    log_group_id = "log-group-id"
    min_level    = "ERROR"
  }
  certificates = [
    "public part of certificate1",
    "public part of certificate2"
  ]
}
```

## Arguments & Attributes Reference

- `certificates` (Set Of String). A set of certificate's fingerprints for the IoT Core Broker.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `log_options` [Block]. Options for logging for IoT Core Broker.
  - `disabled` (Bool). Is logging for broker disabled.
  - `folder_id` (String). Log entries are written to default log group for specified folder.
  - `log_group_id` (String). Log entries are written to specified log group.
  - `min_level` (String). Minimum log entry level.


