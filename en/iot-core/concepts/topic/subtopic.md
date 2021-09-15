# Subtopic

_A subtopic_ is a custom topic created within existing device and registry topics. You don't need to create a subtopic separately, just start sending messages to it.

Everything that is specified after a device or registry topic and separated by `/` is considered a subtopic:

```
<device or registry topic>/<subtopic name>
```

Examples of subtopics:

* `$devices/<device ID>/events/bedroom/temperature` — A subtopic for getting the bedroom temperature.
* `$devices/<device ID>/state/bedroom/temperature` — A subtopic for getting the bedroom temperature, which stores the last message sent to this subtopic.
* `$registries/<registry ID>/commands/bedroom` — A subtopic for sending commands to all devices in the bedroom.
* `$registries/<registry ID>/config/bedroom` — A subtopic for sending commands to all devices in the bedroom, which stores the last message sent to this subtopic.

Subtopics are based on the same [operating principles](./usage.md) and [limits](../limits.md) as topics.

