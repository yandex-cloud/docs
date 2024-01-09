{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится устройство.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите реестр, в котором находится устройство.
   1. Перейдите на вкладку **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Выберите устройство.
   1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация об устройстве.

- CLI {#cli}
  
  {% include [cli-install](../cli-install.md) %}
  
  {% include [default-catalogue](../default-catalogue.md) %}
  
  Получите подробную информацию об устройстве:
  
  ```
  yc iot device get my-device
  ```

  Результат:

  ```
  id: b9135goeh1uc********
  registry_id: b91ki3851hab********
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  ```
  
- API {#api}

  Чтобы получить подробную информацию об устройстве, воспользуйтесь методом REST API [get](../../iot-core/api-ref/Device/get.md) для ресурса [Device](../../iot-core/api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Get](../../iot-core/api-ref/grpc/device_service.md#Get).

{% endlist %}