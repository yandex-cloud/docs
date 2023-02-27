# Registry topics

Registry topics available in the service:
* `$registries/<registry ID>/events`: A topic for receiving telemetry data.
* `$registries/<registry ID>/state`: A permanent topic for receiving telemetry data.

   The device can write data to these topics and the registry can read the data from them. Registries subscribed to these topics won't know which device sent the data, as the topic doesn't contain a unique device ID.

* `$registries/<registry ID>/commands`: A topic for sending commands.
* `$registries/<registry ID>/config`: A permanent topic for sending commands.

   The registry can write data to these topics and the device can read data from them. The registry sends commands for all devices to these topics.

{% include [registry-and-device-topic-note.md](../../../_includes/iot-core/registry-and-device-topic-note.md) %}