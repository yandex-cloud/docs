# Getting information about devices

To find a device's `ID` or `NAME`, get a list of devices in a registry.

## Getting a list of devices in a registry {#device-list}

If you don't know the unique ID or name of the registry where your device is located, view the [list of existing registries](../registry/registry-list.md#registry-list).

{% include [device-list](../../../_includes/iot-core/device-list.md) %}

## Getting information about a device {#device-get}

To access the device, use the `ID` or `NAME` parameters from the [previous](#device-list) item.

{% include [device-get](../../../_includes/iot-core/device-get.md) %}

Device monitoring data is updated when accessing the device via gRPCS and {% if lang == "ru" and audience != "internal" %}[MQTT](../../../glossary/mqtt-server.md){% else %}MQTT{% endif %}. Service quality level: [At most once](../../concepts/index.md#qos).
