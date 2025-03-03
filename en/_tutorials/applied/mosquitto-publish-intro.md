# Sending a message using Mosquitto

You can send the following types of messages:

- Send data from a device to a registry using the `$devices/<device_ID>/events` or `$registries/<registry_ID>/events` topics.
- Send data from a device to a registry using the permanent `$devices/<device_ID>/state` or `$registries/<registry_ID>/state` topics.
- Send registry commands to a device using the `$devices/<device_ID>/commands` or `$registries/<registry_ID>/commands` topics.
- Send registry commands to a device using the permanent `$devices/<device_ID>/config` or `$registries/<registry_ID>/config` topics.