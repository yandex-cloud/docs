# Device topics

{% include [registry-and-device-topic-note.md](../../../_includes/iot-core/registry-and-device-topic-note.md) %}

Device topics available in the service:

* `$devices/<device ID>/events` — A topic for sending telemetry data.

* `$devices/<device ID>/state` — A permanent topic for sending telemetry data.

   The device can write data to these topics and the registry can read the data from them. Registries subscribed to these topics will know which device sent the data, because the topic contains the device ID.

* `$devices/<device ID>/commands` — A topic for receiving commands.

* `$devices/<device ID>/config` — A permanent topic for receiving commands.

   The registry can write data to these topics and the device can read data from them. The registry sends commands for a specific device to these topics.

* `$monitoring/<device ID>/json` — A topic for receiving monitoring data in JSON format.

   The device automatically writes data to this topic and other devices and the registry can read the data from it. The device and registry that are subscribed to this topic will receive up-to-date monitoring data for the device whose ID is specified in the topic.

