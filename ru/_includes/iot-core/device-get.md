{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится устройство.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Выберите реестр, в котором находится устройство.
   1. Перейдите на вкладку **Устройства**.
   1. Выберите устройство.
   1. На странице **Обзор** отобразится подробная информация об устройстве.

- CLI
  
  {% include [cli-install](../cli-install.md) %}
  
  {% include [default-catalogue](../default-catalogue.md) %}
  
  Получите подробную информацию об устройстве:
  
  ```
  yc iot device get my-device
  ```

  Результат:

  ```
  id: b9135goeh1uc1s2i07nm
  registry_id: b91ki3851hab9m0l68je
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  ```
  
- API

  Чтобы получить подробную информацию об устройстве, воспользуйтесь методом REST API [get](../../iot-core/api-ref/Device/get.md) для ресурса [Device](../../iot-core/api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Get](../../iot-core/api-ref/grpc/device_service.md#Get).

{% endlist %}