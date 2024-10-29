{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится устройство.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите реестр, в котором находится устройство.
   1. Перейдите на вкладку **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Выберите устройство.
   1. На странице **{{ ui-key.yacloud.common.overview }}** перейдите к разделу **{{ ui-key.yacloud.iot.label_aliases }}**.

- CLI {#cli}
    
    {% include [cli-install](../cli-install.md) %}
    
    {% include [default-catalogue](../default-catalogue.md) %}
    
    Список алиасов можно получить только для всех устройств в реестре.
    
    Получите список алиасов для всех устройств в реестре:
    
    ```bash
    yc iot registry list-device-topic-aliases my-registry
    ```

    Результат:

    ```text
    +----------+----------------------------------------+----------------------+
    |  ALIAS   |              TOPIC PREFIX              |      DEVICE ID       |
    +----------+----------------------------------------+----------------------+
    | commands | $devices/arenak5ciqss********/commands | arenak5ciqss******** |
    +----------+----------------------------------------+----------------------+
   ```

- API {#api}

   Чтобы получить список алиасов устройства, воспользуйтесь методом REST API [get](../../iot-core/api-ref/Device/get.md) для ресурса [Device](../../iot-core/api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Get](../../iot-core/api-ref/grpc/Device/get.md).

{% endlist %}