# Topic

A _topic_ is a channel for messaging between devices, registries, and broker clients.

Using the broker, you can send and receive messages in any topics that are allowed by the MQTT specification, except for topics starting with a `$` character.

When using device registries, the service provides [device topics](./devices-topic.md) and [registry topics](./registries-topic.md). Device topics identify messages intended for a specific device, and registry topics identify messages intended for all devices in that registry.
Both topic types can have [subtopics](./subtopic.md).

If you have devices with sensor readings that you need to quickly respond to and you may face network communication problems and a broken connection between your devices and the MQTT server, you can subscribe your devices and registries to permanent topics.
For example, use permanent topics for temperature sensors on devices that need to be turned off quickly when heated to a certain temperature.

A _permanent topic_ is a topic that stores the last message sent to this topic so that you can see the current state of the topic when you reconnect your device or registry to the MQTT server.

* [{#T}](./devices-topic.md)
* [{#T}](./registries-topic.md)
* [{#T}](./subtopic.md)
* [{#T}](./usage.md)