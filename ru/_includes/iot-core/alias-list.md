{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится устройство.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Выберите реестр, в котором находится устройство.
   1. Перейдите на вкладку **Устройства**.
   1. Выберите устройство.
   1. На странице **Обзор** перейдите к разделу **Алиасы**.

- CLI
    
    {% include [cli-install](../cli-install.md) %}
    
    {% include [default-catalogue](../default-catalogue.md) %}
    
    Список алиасов можно получить только для всех устройств в реестре.
    
    Получите список алиасов для всех устройств в реестре:
    
    ```
    yc iot registry list-device-topic-aliases my-registry
    ```

    Результат:

    ```
    +----------+----------------------------------------+----------------------+
    |  ALIAS   |              TOPIC PREFIX              |      DEVICE ID       |
    +----------+----------------------------------------+----------------------+
    | commands | $devices/arenak5ciqss6pbas6js/commands | arenak5ciqss6pbas6js |
    +----------+----------------------------------------+----------------------+
   ```

- API

   Чтобы получить список алиасов устройства, воспользуйтесь методом REST API [get](../../iot-core/api-ref/Device/get.md) для ресурса [Device](../../iot-core/api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Get](../../iot-core/api-ref/grpc/device_service.md#Get).

{% endlist %}