{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the registry is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry.
   1. Go to the **{{ ui-key.yacloud.iot.label_devices }}** tab.

- CLI {#cli}

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
   | b9135goeh1uc******** | my-device |
   +----------------------+-----------+
   ```

- API {#api}

   To get a list of devices in a registry, use the [list](../../iot-core/api-ref/Device/list.md) REST API method for the [Device](../../iot-core/api-ref/Device/index.md) resource or the [DeviceService/List](../../iot-core/api-ref/grpc/device_service.md#List) gRPC API call.

{% endlist %}
