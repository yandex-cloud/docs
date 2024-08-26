{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится реестр.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите реестр.
   1. На странице **{{ ui-key.yacloud.common.overview }}** перейдите к разделу **{{ ui-key.yacloud.iot.label_certificates }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Получите список сертификатов реестра:

  ```bash
  yc iot registry certificate list --registry-name my-registry
  ```

  Результат:

  ```text
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | 0f511ea32139178edf73afb953a9cc39******** | 2019-05-29 16:46:23 |
  | 589ce1605019eeff7bb0992f290be0cd******** | 2019-05-29 16:40:48 |
  +------------------------------------------+---------------------+
  ```

- API {#api}

  Чтобы получить список сертификатов реестра, воспользуйтесь методом REST API [listCertificates](../../iot-core/api-ref/Registry/listCertificates.md) для ресурса [Registry](../../iot-core/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/ListCertificates](../../iot-core/api-ref/grpc/registry_service.md#ListCertificates).

{% endlist %}