# Viewing the connection log

The log contains information about connecting/disconnecting devices and errors. You can view connection logs for a [device](#device) and [registry](#registry).

## View the device connection log {#device}

The device connection log contains information about operations performed with the device certificate.

To access a [device](../concepts/index.md#device), use its ID or name. For information about how to get its ID or name, see [{#T}](device/device-list.md)

{% list tabs %}

- Management console

   To view the device connection log:
   1. In the [management console]({{ link-console-main }}), select the folder to view the device connection log in.
   1. Select **{{ iot-name }}**.
   1. Select the registry with the desired device from the list.
   1. In the left part of the window, select **Devices**.
   1. Select the desired device from the list.
   1. In the left part of the window, select **Logs**.

   The **Logs** window shows the device connection log.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  View the device connection log:

  ```
  $ yc iot devices logs my-device
  
  2019-09-19 18:52:03     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53189", clientID: "YCCmdLine"
  2019-09-19 18:52:03     disconnected: publish to topic "$device/areqjd6un3afc3cefcvm/events" not allowed
  2019-09-19 18:52:38     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53201", clientID: "YCCmdLine"
  2019-09-19 18:52:38     disconnected: publish to topic "$device/areqjd6un3afc3cefcvm/events" not allowed
  2019-09-19 18:52:51     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53206", clientID: "YCCmdLine"
  2019-09-19 18:52:51     disconnected: client disconnected
  2019-09-19 18:53:01     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53213", clientID: "YCCmdLine"
  2019-09-19 18:53:01     disconnected: client disconnected
  2019-09-19 18:53:03     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53217", clientID: "YCCmdLine"
  2019-09-19 18:53:03     disconnected: client disconnected
  2019-09-19 18:53:04     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53220", clientID: "YCCmdLine"
  2019-09-19 18:53:04     disconnected: client disconnected
  ```

{% endlist %}

## View the registry connection log {#registry}

The registry connection log contains information about operations performed with the registry certificate. Operations of devices that belong to this registry are not included in this log.

To access a [registry](../concepts/index.md#registry), use its ID or name. For information about how to get the registry ID or name, see [{#T}](registry/registry-list.md)

{% list tabs %}

- Management console

   To view the registry connection log:
   1. In the [management console]({{ link-console-main }}), select the folder to view the registry connection log in.
   1. Select **{{ iot-name }}**.
   1. Select the registry with the desired device from the list.
   1. In the left part of the window, select **Logs**.

   The **Logs** window shows the registry connection log.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  View the registry connection log:

  ```
  $ yc iot registry logs my-registry
  
  2019-09-19 18:51:02     connected, cert: "94ea0421199ec70f1f3d359a1c167a81de4cf6ec", address: "77.88.15.128:53171", clientID: "YCCmdLine"
  2019-09-19 18:51:02     some of subscriptions failed: not allowed to subscribe: ["$device/areqjd6un3afc3cefcvm/events"]
  2019-09-19 18:52:30     disconnected: client disconnected
  2019-09-19 18:52:36     connected, cert: "94ea0421199ec70f1f3d359a1c167a81de4cf6ec", address: "77.88.15.128:53198", clientID: "YCCmdLine"
  2019-09-19 18:52:36     some of subscriptions failed: not allowed to subscribe: ["$device/areqjd6un3afc3cefcvm/events"]
  2019-09-19 18:52:54     disconnected: client disconnected
  2019-09-19 18:52:58     connected, cert: "94ea0421199ec70f1f3d359a1c167a81de4cf6ec", address: "77.88.15.128:53209", clientID: "YCCmdLine"
  2019-09-19 18:53:32     disconnected: client disconnected
  ```

{% endlist %}

