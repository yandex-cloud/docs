# Getting information about devices

To find out the unique ID or name of a device, [get](#device-list) a list of devices in a registry.

## Getting a list of devices in a registry {#device-list}

If you don't know the unique ID or name of the registry where your device is located, view the [list of existing registries](../registry/registry-list.md#registry-list).

{% include [device-list](../../../_includes/iot-core/device-list.md) %}

## Getting information about a device {#device-get}

To access a device, use the unique ID or name of the registry from the [previous](#device-list) step.

{% include [device-get](../../../_includes/iot-core/device-get.md) %}

Device monitoring data is updated when accessing the device via gRPCS and MQTT. The quality of service (QoS) level is [at most once](../../concepts/index.md#qos).
