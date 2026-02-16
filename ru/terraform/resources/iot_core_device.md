---
subcategory: IoT Core Devices
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/iot_core_device.md
---

# yandex_iot_core_device (Resource)

Allows management of [Yandex Cloud IoT Device](https://yandex.cloud/docs/iot-core/quickstart).

## Example usage

```terraform
//
// Create a new IoT Core Device.
//
resource "yandex_iot_core_device" "my_device" {
  registry_id = "are1sampleregistryid11"
  name        = "some_name"
  description = "any description"
  aliases = {
    "some_alias1/subtopic" = "$devices/{id}/events/somesubtopic",
    "some_alias2/subtopic" = "$devices/{id}/events/aaa/bbb",
  }
  passwords = [
    "my-password1",
    "my-password2"
  ]
  certificates = [
    "public part of certificate1",
    "public part of certificate2"
  ]
}
```

## Arguments & Attributes Reference

- `aliases` (Map Of String). A set of key/value aliases pairs to assign to the IoT Core Device.
- `certificates` (Set Of String). A set of certificate's fingerprints for the IoT Core Device.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `passwords` (Set Of String). A set of passwords's id for the IoT Core Device.
- `registry_id` (**Required**)(String). IoT Core Registry ID for the IoT Core Device.


