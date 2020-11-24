{% list tabs %}

- Management console
   1. In the [management console]({{ link-console-main }}), select the folder where the device is located.
   1. Select the **{{ iot-name }}**.
   1. Select the registry where the device is located.
   1. Go to the **Devices** tab.
   1. Select the device.
   1. The **Overview** page shows the device details.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Get detailed information about a device:

  ```
  yc iot device get my-device
  ```

  Result:

  ```
  id: b9135goeh1uc1s2i07nm
  registry_id: b91ki3851hab9m0l68je
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  ```

- API

  You can get detailed information about a device using the [get](../../iot-core/api-ref/Device/get.md) API method.

{% endlist %}
