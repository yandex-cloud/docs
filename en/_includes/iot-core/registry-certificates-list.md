{% list tabs %}

- Management console
   1. In the [management console]({{ link-console-main }}), select the folder where the registry is located.
   1. Select the **{{ iot-name }}**.
   1. Select the registry.
   1. On the **Overview** page, go to the **Certificates** section.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Get a list of registry certificates:

  ```
  yc iot registry certificate list --registry-name my-registry
  ```

  Result:

  ```
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | 0f511ea32139178edf73afb953a9cc398f33adf1 | 2019-05-29 16:46:23 |
  | 589ce1605019eeff7bb0992f290be0cd708ecc6c | 2019-05-29 16:40:48 |
  +------------------------------------------+---------------------+
  ```

- API

  You can get a list of registry certificates using the [listCertificates](../../iot-core/api-ref/Registry/listCertificates.md) API method.

{% endlist %}