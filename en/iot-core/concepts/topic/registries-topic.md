---
title: Registry topics in {{ iot-full-name }}
description: This page describes all registry topics available in {{ iot-name }}.
---

# Registry topics

Registry topics available in the service: 
* `$registries/<registry_ID>/events`: Topic for receiving telemetry data.
* `$registries/<registry_ID>/state`: Permanent topic for receiving telemetry data.

    The device can write data to these topics and the registry can read the data from them. The registry subscribed to these topics will not know which device sent the data, as the topic does not contain a unique device ID.

* `$registries/<registry_ID>/commands`: Topic for sending commands.
* `$registries/<registry_ID>/config`: Permanent topic for sending commands.

    The registry can write data to these topics and the device can read data from them. The registry sends commands for all devices to these topics.

{% include [registry-and-device-topic-note.md](../../../_includes/iot-core/registry-and-device-topic-note.md) %}