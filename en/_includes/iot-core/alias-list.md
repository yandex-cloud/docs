{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the device is located.
   1. Select **{{ iot-short-name }}**.
   1. Select the registry where the device is located.
   1. Go to the **Devices** tab.
   1. Select the device.
   1. On the **Overview** page, go to the **Aliases** section.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   You can only get a list of aliases for all devices in the registry.

   Get a list of aliases for all devices in the registry:

   ```
   yc iot registry list-device-topic-aliases my-registry
   ```

   Result:

   ```
   +----------+----------------------------------------+----------------------+
   |  ALIAS   |              TOPIC PREFIX              |      DEVICE ID       |
   +----------+----------------------------------------+----------------------+
   | commands | $devices/arenak5ciqss6pbas6js/commands | arenak5ciqss6pbas6js |
   +----------+----------------------------------------+----------------------+
   ```

- API

   To get a list of device aliases, use the [get](../../iot-core/api-ref/Device/get.md) REST API method for the [Device](../../iot-core/api-ref/Device/index.md) resource or the [DeviceService/Get](../../iot-core/api-ref/grpc/device_service.md#Get) gRPC API call.

{% endlist %}