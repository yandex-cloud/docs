# Viewing the connection log

The log contains information about connecting/disconnecting devices and errors. You can view connection logs for the [registry](#registry) and [devices](#device). Time is specified in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).

## View the registry connection log {#registry}

The registry connection log contains information about operations performed with the registry certificate. Operations of devices that belong to this registry are not included in this log.

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the folder to view the registry connection log in.
    1. Select **{{ iot-short-name }}**.
    1. Select the registry with the desired device from the list.
    1. In the left part of the window, select **Logs**.

- CLI

  {% include [timeslot](../../_includes/functions/timeslot.md) %}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. [Get](registry/registry-list.md##registry-list) a list of registries in a folder.

  1. View the registry connection log:

        ```
        yc iot registry logs my-registry
        ```

        Result:
        ```
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

## View the device connection log {#device}

The device connection log contains information about operations performed with the device certificate.

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the folder to view the device connection log in.
    1. Select **{{ iot-short-name }}**.
    1. Select the registry with the desired device from the list.
    1. In the left part of the window, select **Devices**.
    1. Select the desired device from the list.
    1. In the left part of the window, select **Logs**.

- CLI

    {% include [timeslot](../../_includes/functions/timeslot.md) %}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. [Get](device/device-list.md##device-list) a list of devices in a registry.

    2. View the device connection log:

        ```
        yc iot devices logs my-device
        ```

        Result:
        ```
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