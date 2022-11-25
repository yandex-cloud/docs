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

   You can get a list of broker certificates using the [listCertificates](../../iot-core/broker/api-ref/Broker/listCertificates.md) API method.

{% endlist %}