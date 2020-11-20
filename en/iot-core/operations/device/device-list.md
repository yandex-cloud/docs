# Getting information about devices

To find a device's `ID` or `NAME`, get a list of devices in a registry or detailed information about the device.

## Getting a list of devices in a registry {#device-list}

If you don't know the unique ID or name of the registry where your device is located, [view the list of existing registries](../registry/registry-list.md#registry-list).

{% list tabs %}

- Management console

   To view the list of devices:
   1. In the [management console]({{ link-console-main }}), select the folder to get the list of devices in.
   1. Select **{{ iot-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Get a list of [devices](../../concepts/index.md#device) in a registry:

  ```
  $ yc iot device list --registry-name my-registry
  
  +----------------------+-----------+
  |          ID          |   NAME    |
  +----------------------+-----------+
  | b9135goeh1uc1s2i07nm | my-device |
  +----------------------+-----------+
  ```

{% endlist %}

## Getting detailed information about a device {#device-get}

To access the device, use the `ID` or `NAME` parameters from the [previous](#device-list) item.

{% list tabs %}

- Management console

   To get detailed information about a device:
   1. In the [management console]({{ link-console-main }}), select the folder to get the device details in.
   1. Select **{{ iot-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. In the **Devices** list, select the desired device.

   The **Overview** window shows the device details.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Get detailed information about a device:

  ```
  $ yc iot device get my-device
  
  id: b9135goeh1uc1s2i07nm
  registry_id: b91ki3851hab9m0l68je
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  ```

{% endlist %}

