{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the registry is located.
   1. Select **{{ iot-short-name }}**.
   1. Select the registry.
   1. Go to the **Devices** tab.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   Get a list of devices in the registry:

   ```
   yc iot device list --registry-name my-registry
   ```

   Result:

   ```
   +----------------------+-----------+
   |          ID          |   NAME    |
   +----------------------+-----------+
   | b9135goeh1uc1s2i07nm | my-device |
   +----------------------+-----------+
   ```

- API

   To get a list of devices in a registry, use the [list](../../iot-core/api-ref/Device/list.md) REST API method for the [Device](../../iot-core/api-ref/Device/index.md) resource or the [DeviceService/List](../../iot-core/api-ref/grpc/device_service.md#List) gRPC API call.

{% endlist %}
