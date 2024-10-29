{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится брокер.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. На панели слева выберите **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. Выберите брокер. Список сертификатов отобразится в разделе **{{ ui-key.yacloud.iot.label_certificates }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Получите список сертификатов брокера:

  ```bash
  yc iot broker certificate list --broker-name my-broker
  ```

  Результат:

  ```text
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | 0f511ea32139178edf73afb953a9cc********** | 2019-05-29 16:46:23 |
  | 589ce1605019eeff7bb0992f290be0********** | 2019-05-29 16:40:48 |
  +------------------------------------------+---------------------+
  ```

- API {#api}

  Чтобы получить список сертификатов брокера, воспользуйтесь методом REST API [listCertificates](../../iot-core/broker/api-ref/Broker/listCertificates.md) для ресурса [Broker](../../iot-core/broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/ListCertificates](../../iot-core/broker/api-ref/grpc/Broker/listCertificates.md).

{% endlist %}