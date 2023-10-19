{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the device is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry where the device is located.
   1. Go to the **{{ ui-key.yacloud.iot.label_devices }}** tab.
   1. Select the device.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, go to the **{{ ui-key.yacloud.iot.label_certificates }}** section.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  View the list of device certificates:

  ```
  yc iot device certificate list --device-name my-device
  ```

  Result:

  ```
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | df3cc4f337eba01a264803d15b119e2d33943315 | 2019-05-29 17:14:36 |
  | 65e5b050069da5ca5996a4a8a92514098b0a5dd1 | 2019-05-29 17:14:18 |
  +------------------------------------------+---------------------+
  ```

- API

  To get a list of device certificates, use the [listCertificates](../../iot-core/api-ref/Device/listCertificates.md) REST API method for the [Device](../../iot-core/api-ref/Device/index.md) resource or the [DeviceService/ListCertificates](../../iot-core/api-ref/grpc/device_service.md#ListCertificates) gRPC API call.

{% endlist %}