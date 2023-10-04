{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится реестр.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите реестр.
   1. На странице **{{ ui-key.yacloud.common.overview }}** перейдите к разделу **{{ ui-key.yacloud.iot.label_certificates }}**.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Получите список сертификатов реестра:

  ```
  yc iot registry certificate list --registry-name my-registry
  ```

  Результат:

  ```
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | 0f511ea32139178edf73afb953a9cc398f33adf1 | 2019-05-29 16:46:23 |
  | 589ce1605019eeff7bb0992f290be0cd708ecc6c | 2019-05-29 16:40:48 |
  +------------------------------------------+---------------------+
  ```

- API

  Чтобы получить список сертификатов реестра, воспользуйтесь методом REST API [listCertificates](../../iot-core/api-ref/Registry/listCertificates.md) для ресурса [Registry](../../iot-core/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/ListCertificates](../../iot-core/api-ref/grpc/registry_service.md#ListCertificates).

{% endlist %}