{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the device is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry where the device is located.
   1. Go to the **{{ ui-key.yacloud.iot.label_devices }}** tab.
   1. Select the device.
   1. The **{{ ui-key.yacloud.common.overview }}** page will show the device details.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Get detailed information about a device:

  ```
  yc iot device get my-device
  ```

  Result:

  ```
  id: b9135goeh1uc********
  registry_id: b91ki3851hab********
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  ```

- API

  To get detailed information about a device, use the [get](../../iot-core/api-ref/Device/get.md) REST API method for the [Device](../../iot-core/api-ref/Device/index.md) resource or the [DeviceService/Get](../../iot-core/api-ref/grpc/device_service.md#Get) gRPC API call.

{% endlist %}