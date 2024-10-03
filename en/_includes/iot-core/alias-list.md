{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the device is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry where the device is located.
   1. Go to the **{{ ui-key.yacloud.iot.label_devices }}** tab.
   1. Select the device.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, go to the **{{ ui-key.yacloud.iot.label_aliases }}** section.

- CLI {#cli}
    
    {% include [cli-install](../cli-install.md) %}
    
    {% include [default-catalogue](../default-catalogue.md) %}
    
    You can only get a list of aliases for all devices in the registry.
    
    Get a list of aliases for all devices in the registry:
    
    ```bash
    yc iot registry list-device-topic-aliases my-registry
    ```

    Result:

    ```text
    +----------+----------------------------------------+----------------------+
    |  ALIAS   |              TOPIC PREFIX              |      DEVICE ID       |
    +----------+----------------------------------------+----------------------+
    | commands | $devices/arenak5ciqss********/commands | arenak5ciqss******** |
    +----------+----------------------------------------+----------------------+
   ```

- API {#api}

   To get a list of device aliases, use the [get](../../iot-core/api-ref/Device/get.md) REST API method for the [Device](../../iot-core/api-ref/Device/index.md) resource or the [DeviceService/Get](../../iot-core/api-ref/grpc/device_service.md#Get) gRPC API call.

{% endlist %}