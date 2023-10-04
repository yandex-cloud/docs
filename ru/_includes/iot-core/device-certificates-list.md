{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится устройство.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите реестр, в котором находится устройство.
   1. Перейдите на вкладку **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Выберите устройство.
   1. На странице **{{ ui-key.yacloud.common.overview }}** перейдите к разделу **{{ ui-key.yacloud.iot.label_certificates }}**.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Посмотрите список сертификатов устройства:

  ```
  yc iot device certificate list --device-name my-device
  ```

  Результат:

  ```
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | df3cc4f337eba01a264803d15b119e2d33943315 | 2019-05-29 17:14:36 |
  | 65e5b050069da5ca5996a4a8a92514098b0a5dd1 | 2019-05-29 17:14:18 |
  +------------------------------------------+---------------------+
  ```

- API

  Чтобы получить список сертификатов устройства, воспользуйтесь методом REST API [listCertificates](../../iot-core/api-ref/Device/listCertificates.md) для ресурса [Device](../../iot-core/api-ref/Device/index.md) или вызовом gRPC API [DeviceService/ListCertificates](../../iot-core/api-ref/grpc/device_service.md#ListCertificates).

{% endlist %}