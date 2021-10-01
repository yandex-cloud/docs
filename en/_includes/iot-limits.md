#### Quotas {#iot-quotas}

Type of limit | Value
----- | -----
Number of registries per cloud | 10
Number of devices per cloud | 1000

#### Limits {#iot-limits}

Type of limit | Value
----- | -----
Maximum size per message | 256 KB
Frequency of sending messages per device | No more than once per second
Maximum length of the [subtopic](../iot-core/concepts/topic/subtopic.md) name | 1024 symbols
Maximum number of [aliases](../iot-core/concepts/topic/usage.md#aliases) per device | 5

{% note info %}

Message delivery is not guaranteed if the limits are exceeded.

{% endnote %}

#### Other restrictions {#iot-other-restrictions}

* The `Retain` flag is not supported. When using it, the MQTT broker saves the flagged message and sends it the next time you subscribe a device or registry to a topic.
* Persistent Sessions, when the MQTT broker saves information about a client (device or registry) to reconnect faster, aren't supported.
