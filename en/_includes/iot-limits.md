#### Quotas {#iot-quotas}

| Type of limit | Value |
----- | -----
| Number of registries per cloud | 10 |
| Number of devices per cloud | 1,000 |
| Number of brokers per cloud | 10 |
| Frequency of sending messages per broker | 50 per second |
| Number of clients concurrently connected to the broker | 50 |


#### Limits {#iot-limits}

| Type of limit | Value |
----- | -----
| Maximum size per message | 256 KB |
| Frequency of sending messages per device | No more than once per second |
| Maximum [subtopic](../iot-core/concepts/topic/subtopic.md) name length | 1,024 characters |
| Maximum number of [aliases](../iot-core/concepts/topic/usage.md#aliases) per device | 5 |

{% note info %}

Message delivery is not guaranteed if the limits are exceeded.

{% endnote %}

#### Other restrictions {#iot-other-restrictions}

* The `Retain` flag is not supported. When using it, the MQTT broker saves the flagged message and sends it when you subscribe a device or registry to a topic next time.
* Persistent sessions, when the MQTT broker saves information about a client (device or registry) to reconnect faster, are not supported.
* The `QoS 2: Exactly once` quality of service level for MQTT is not supported.
* There is no guarantee that the devices or registries with the same [ClientID](https://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html#_Toc385349242) cannot connect to the MQTT broker at the same time.
