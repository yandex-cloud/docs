# Subtopic

A _subtopic_ is a custom topic created within existing device and registry topics. You do not need to create a subtopic, just start sending messages to it.

Everything that is specified after a device or registry topic and separated by `/` is considered a subtopic:

```
<device_or_registry_topic>/<subtopic_name>
```

Examples of subtopics:
* `$devices/<device_ID>/events/bedroom/temperature`: Subtopic for receiving bedroom temperature data.
* `$devices/<device_ID>/state/bedroom/temperature`: Subtopic for receiving bedroom temperature data, which stores the most recent message sent to this subtopic.
* `$registries/<registry_ID>/commands/bedroom`: Subtopic for sending commands to all devices in the bedroom.
* `$registries/<registry_ID>/config/bedroom`: Subtopic for sending commands to all devices in the bedroom, which stores the most recent message sent to this subtopic.

Subtopics are based on the same [operating principles](./usage.md) and [limits](../limits.md) as topics.