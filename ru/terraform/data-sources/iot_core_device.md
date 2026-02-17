---
subcategory: IoT Core Devices
---

# yandex_iot_core_device (DataSource)

Get information about a Yandex IoT Core device. For more information about IoT Core, see [Yandex Cloud IoT Device](https://yandex.cloud/docs/iot-core/quickstart).
This data source is used to define [Yandex Cloud IoT Device](https://yandex.cloud/docs/iot-core/quickstart) that can be used by other resources.

{% note warning %}

Either `device_id` or `name` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing IoT Core Device.
//
data "yandex_iot_core_device" "my_device" {
  device_id = "are1sampleregistry11"
}
```

## Arguments & Attributes Reference

- `aliases` (Map Of String). A set of key/value aliases pairs to assign to the IoT Core Device.
- `certificates` (Set Of String). A set of certificate's fingerprints for the IoT Core Device.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `device_id` (String). IoT Core Device id used to define device.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `passwords` (Set Of String). A set of passwords's id for the IoT Core Device.
- `registry_id` (**Required**)(String). IoT Core Registry ID for the IoT Core Device.


