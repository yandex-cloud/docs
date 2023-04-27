{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится брокер.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. На панели слева выберите **Брокеры**.
   1. Выберите брокер. Список сертификатов отобразится в разделе **Сертификаты**.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Получите список сертификатов брокера:

  ```
  yc iot broker certificate list --broker-name my-broker
  ```

  Результат:

  ```
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | 0f511ea32139178edf73afb953a9cc********** | 2019-05-29 16:46:23 |
  | 589ce1605019eeff7bb0992f290be0********** | 2019-05-29 16:40:48 |
  +------------------------------------------+---------------------+
  ```

- API

  Чтобы получить список сертификатов брокера, воспользуйтесь методом REST API [listCertificates](../../iot-core/broker/api-ref/Broker/listCertificates.md) для ресурса [Broker](../../iot-core/broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/ListCertificates](../../iot-core/broker/api-ref/grpc/broker_service.md#ListCertificates).

{% endlist %}