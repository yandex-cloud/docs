{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the device is located.
   1. Select **{{ iot-short-name }}**.
   1. Select the registry where the device is located.
   1. Go to the **Devices** tab.
   1. Select the device.
   1. On the **Overview** page, go to the **Certificates** section.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  View the list of device certificates:

  ```
  yc iot device certificate list --device-name my-device
  ```

  Result:

  ```
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | df3cc4f337eba01a264803d15b119e2d33943315 | 2019-05-29 17:14:36 |
  | 65e5b050069da5ca5996a4a8a92514098b0a5dd1 | 2019-05-29 17:14:18 |
  +------------------------------------------+---------------------+
  ```

- API

  You can get a list of device certificates using the [listCertificates](../../iot-core/api-ref/Device/listCertificates.md) API method.

{% endlist %}