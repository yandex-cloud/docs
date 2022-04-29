{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder where the registry is located.
  1. Select the **{{ iot-short-name }}**.
  1. Select the registry.
  1. Go to the **Devices** tab.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Get a list of devices in the registry:

  ```
	yc iot device list --registry-name my-registry
  ```

  Result:

  ```
	+----------------------+-----------+
	|          ID          |   NAME    |
	+----------------------+-----------+
	| b9135goeh1uc1s2i07nm | my-device |
	+----------------------+-----------+
  ```

- API

  You can get a list of registry devices using the [list](../../iot-core/api-ref/Device/list) API method.

{% endlist %}