{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the broker is located.
   1. Select **{{ iot-short-name }}**.
   1. On the left-hand panel, select **Brokers**.
   1. Select the broker. A list of certificates will be displayed in the **Certificates** section.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   Get a list of broker certificates:

   ```
   yc iot broker certificate list --broker-name my-broker
   ```

   Result:

   ```
   +------------------------------------------+---------------------+
   |               FINGERPRINT                |     CREATED AT      |
   +------------------------------------------+---------------------+
   | 0f511ea32139178edf73afb953a9cc********** | 2019-05-29 16:46:23 |
   | 589ce1605019eeff7bb0992f290be0********** | 2019-05-29 16:40:48 |
   +------------------------------------------+---------------------+
   ```

- API

   To get a list of broker certificates, use the [listCertificates](../../iot-core/broker/api-ref/Broker/listCertificates.md) REST API method for the [Broker](../../iot-core/broker/api-ref/Broker/index.md) resource or the [BrokerService/ListCertificates](../../iot-core/broker/api-ref/grpc/broker_service.md#ListCertificates) gRPC API call.

{% endlist %}